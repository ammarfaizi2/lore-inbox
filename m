Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266751AbUHOO7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUHOO7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUHOO7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:59:41 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:62177 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266751AbUHOO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:59:21 -0400
Date: Sun, 15 Aug 2004 11:03:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: [PATCH][2.6-mm] i386 Hotplug CPU
In-Reply-To: <20040815144655.GA784@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0408151056380.22078@montezuma.fsmlabs.com>
References: <1090870667.22306.40.camel@pants.austin.ibm.com>
 <20040726170157.7f4b414c.akpm@osdl.org> <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0407270440200.23985@montezuma.fsmlabs.com>
 <20040811135019.GC1120@openzaurus.ucw.cz> <Pine.LNX.4.58.0408112043100.2544@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408142313450.22078@montezuma.fsmlabs.com>
 <20040815144655.GA784@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Pavel Machek wrote:

> > > Yeah i recall you mentioning this earlier, i'll look into adding the
> > > necessary bits so that you have enough state to resume from. Your
> > > mentioning this was one of the reasons i wanted this in.
> >
> > Pavel, considering that the processor is in a quiescent state when it's in
> > the idle thread, can't we simply restart them all when we do the final
> > sleep? So on the resume, we steer the APs straight into the offline cpu
> > spin and manually bring them up again when the BSP has resumed? I
> > reckon
>
> Sorry, I do not understand what AP and BSP means in this context.

My mistake, Application and Bootstrap Processors.

> Yes, we can just shut those cpus down on suspend and completely boot
> them from real mode during resume... that should work. And we will
> need to do that during suspend-to-ram.

Thanks i just wanted to run that by you first.

