Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbTCWUIG>; Sun, 23 Mar 2003 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263176AbTCWUIG>; Sun, 23 Mar 2003 15:08:06 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:44302 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263175AbTCWUIF>; Sun, 23 Mar 2003 15:08:05 -0500
Date: Sun, 23 Mar 2003 20:19:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: dan carpenter <d_carpenter@sbcglobal.net>
cc: Brian Gerst <bgerst@didntduck.org>, Thomas Molina <tmolina@cox.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sleeping function call in 2.5.65-bk
In-Reply-To: <200303231905.h2NJ57OU665784@pimout3-ext.prodigy.net>
Message-ID: <Pine.LNX.4.44.0303232016050.5720-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sunday 23 March 2003 05:30 pm, Brian Gerst wrote:
> >
> > The fbcon driver is calling kmalloc in interrupt context without
> > GFP_ATOMIC.
> 
> Good call.  This is compile tested only.

Very few cards actaully use a VBL. Each driver also should provide its own 
interrupt handler. Plus the "generic" vbl handler should NOT be calling 
accel_cursor. Instead talking to the low level cursor handler instead. I 
plan to do that next. I haven't got around to fixing that yet. I will in 
the next release.


