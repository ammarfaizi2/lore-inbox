Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWH0ST2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWH0ST2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWH0ST1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:19:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46536 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932234AbWH0ST1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:19:27 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
Date: Sun, 27 Aug 2006 20:19:15 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org> <200608271757.18621.ak@suse.de> <44F1D464.5020304@goop.org>
In-Reply-To: <44F1D464.5020304@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272019.15067.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 19:20, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> +1:	movw GS(%esp), %gs
> >>     
> >
> > movl is recommended in 32bit mode
> >   
> 
> arch/i386/kernel/entry.S: Assembler messages:
> arch/i386/kernel/entry.S:334: Error: suffix or operands invalid for `mov'

Looks like a gas bug to me.

-Andi
