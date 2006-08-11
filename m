Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160994AbWHKGyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWHKGyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWHKGyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:54:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:46221 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932418AbWHKGyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:54:37 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [145/145] i386: Disallow kprobes on NMI handlers
Date: Fri, 11 Aug 2006 08:53:19 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200608110240_MC3-1-C7C3-777A@compuserve.com>
In-Reply-To: <200608110240_MC3-1-C7C3-777A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110853.19740.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 08:37, Chuck Ebbert wrote:
> In-Reply-To: <20060810193745.DBBAA13B8E@wotan.suse.de>
> 
> On Thu, 10 Aug 2006 21:37:45 +0200, Andi Kleen wrote:
> 
> > --- linux.orig/arch/i386/kernel/entry.S
> > +++ linux/arch/i386/kernel/entry.S
> > @@ -725,7 +725,7 @@ debug_stack_correct:
> >   * check whether we got an NMI on the debug path where the debug
> >   * fault happened on the sysenter path.
> >   */
> > -ENTRY(nmi)
> > +KPROBE_ENTRY(nmi)
> >       RING0_INT_FRAME
> >       pushl %eax
> >       CFI_ADJUST_CFA_OFFSET 4
> 
> Needs .popsection at the end of the NMI code.

This is fixed up in a later patch I think.
i386: KPROBE_ENTRY ends up putting code into .fixup


-andi
