Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSLTSCP>; Fri, 20 Dec 2002 13:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLTSCO>; Fri, 20 Dec 2002 13:02:14 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:47876 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263256AbSLTSCO>; Fri, 20 Dec 2002 13:02:14 -0500
Date: Fri, 20 Dec 2002 18:10:17 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
In-Reply-To: <20021219231415.A25145@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212201808070.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm in the midst of porting sa1100fb over to the new fb API, and I stumbled
> across an apparant confusion over the type of fb_info->pseudo_palette.
> 
> Some code appears to think its an unsigned long, others think its u32.
> This doesn't make much difference when sizeof(unsigned long) == sizeof(u32)
> but this isn't always the case (eg, 64-bit architectures).

It show be u32 instead of unsinged long in color_imageblit. Thanks. Fixed.
 
> I'll get back to bashing the sa1100fb driver to work out why fbcon is
> producing a _completely_ blank display, despite characters being written
> to it.

Did you figure out what was wrong?

