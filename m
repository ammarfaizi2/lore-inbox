Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbUKIXLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUKIXLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKIXLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:11:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36058 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261715AbUKIXLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:11:52 -0500
Date: Tue, 9 Nov 2004 18:12:23 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA loosing interrupts
In-Reply-To: <1100039481l.6523l.1l@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0411091808130.31999-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Nov 2004, J.A. Magallon wrote:

> Hi...
> 
> Apart from this, 2.6.9-mm1 is fairly stable (Congrats!), I use it as
> samba server and is working fine. But sometimes I get this, and the
> box gets unresponsive:
> 
> Nov  6 04:05:54 nada kernel: ata5: command timeout
> Nov  6 04:06:19 nada kernel: hde: dma_timer_expiry: dma status == 0x24
> Nov  6 04:06:29 nada kernel: hde: DMA interrupt recovery
> Nov  6 04:06:29 nada kernel: hde: lost interrupt
> 
> Any ata5 is a SATA channel on the second of two Promise cards.
> 
> Any ideas ?
> 

I'm not sure what the cause of this is, but this does indeed to be a 
common problem. This is the second e-mail today on lkml about this and 
i've seen it logged against a couple of distros. 

I've hit it on a test system as well, which runs 2.4.9, 2.4.21, without
problems, but hits the above error on 2.6.9, and the system becomes
completely unresponsive. Another note of interest is that i've seen the 
following message in the logs:

psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing...

So indeed it seems like some sort of timing issue?

-Jason

