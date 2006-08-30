Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWH3UGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWH3UGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWH3UGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:06:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:53153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751470AbWH3UGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:06:41 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 22:06:46 +0200
User-Agent: KMail/1.9.3
Cc: pageexec@freemail.hu, davej@redhat.com, linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <200608302136.54624.ak@suse.de> <20060830200354.GA496@1wt.eu>
In-Reply-To: <20060830200354.GA496@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302206.46898.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 22:03, Willy Tarreau wrote:
> On Wed, Aug 30, 2006 at 09:36:54PM +0200, Andi Kleen wrote:
> > 
> > > Andi, if you remove the HLT here, some CPUs will spin at full speed. This
> > > is nasty during boot because some of them might not have enabled their
> > > fans yet for instance
> > 
> > That would be a severe bug in the platform. Basically always the fans are managed
> > by SMM code.
> 
> It was just an example. Other examples include virtual machines never
> stopping because they will see the guest is working and not halted.

They have to deal with that anyways because the machine can just
crash with a busy loop. And BTW -- take a look at the normal panic.

-Andi

