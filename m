Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbTIKVnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbTIKVnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:43:18 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:19074
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261553AbTIKVnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:43:15 -0400
Date: Thu, 11 Sep 2003 17:43:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Maciej Babinski <maciej@apathy.killer-robot.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
In-Reply-To: <20030911174331.GA1678@apathy.black-flower>
Message-ID: <Pine.LNX.4.53.0309111741230.6886@montezuma.fsmlabs.com>
References: <20030910191459.GA12099@apathy.black-flower>
 <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
 <20030911174331.GA1678@apathy.black-flower>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Maciej Babinski wrote:

> > That number looks highly suspect; see patch below
> > 
> 
> This changes the mask to 00000003. Much more reasonable.

Cool.

> I didn't have irqbalanced running. After some investigation, setting
> the mask to 00000002 gets interrupts to hit cpu 1. Setting it to
> 00000001 or 00000003 gets all interrupts to hit cpu 0. Setting
> noirqbalance doesn't do anything to change this. 

0x2 will hit cpu1 because we currently do a find first bit on the 
mask you specify. As for noirqbalance not working, that's a kernel bug, 
i'll check it out.
