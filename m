Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTLQXi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbTLQXi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:38:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264830AbTLQXi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:38:27 -0500
Date: Wed, 17 Dec 2003 18:38:25 -0500
From: Alan Cox <alan@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031217233825.GK10132@devserv.devel.redhat.com>
References: <131Ac-5Qy-3@gated-at.bofh.it> <137cD-8eg-9@gated-at.bofh.it> <13kD2-1kF-11@gated-at.bofh.it> <13qIi-31G-1@gated-at.bofh.it> <13DvZ-2RY-9@gated-at.bofh.it> <13DFw-3a8-9@gated-at.bofh.it> <13DPq-3s4-7@gated-at.bofh.it> <13Fem-6iy-7@gated-at.bofh.it> <13SY1-35z-19@gated-at.bofh.it> <m3hdzzni79.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hdzzni79.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 12:22:02AM +0100, Andi Kleen wrote:
> Alan Cox <alan@redhat.com> writes:
> >
> > And X11 will want to access it via /proc interfaces. And someone will eventually
> > go and design a different way to access PCI-EX for their hardware 8)
> 
> It would be nice if it did. Just currently it uses racy port accesses
> from user space :-(

Depends what patches you applied and how you built it 8) However XFree meets
hotplug is so unfunny its not good to consider before dinner, nor XFree meets
irqs or XFree meets SAK and high security models.

Linus had a nice comment that the basic DRI/fb modules should be dealing with
the PCI layer and perhaps exposing the DMA engine for newer cards (to trusted
parties). For older cards there are all sorts of reasons you don't want to do
this on the performance side but even then a driver which refused to free up
the PCI map space until X noticed the file handle was returning errors and
selected EOF would make a lot of the stuff sort out.

Maybe in part the GGI folks were right all those years ago. We had two extreme
views and the middle may be closer

Alan

