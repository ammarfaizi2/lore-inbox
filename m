Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbSJ0EZ5>; Sun, 27 Oct 2002 00:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSJ0EZ5>; Sun, 27 Oct 2002 00:25:57 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:57332 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S262120AbSJ0EZ4>; Sun, 27 Oct 2002 00:25:56 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758C68@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, Dave Jones <davej@codemonkey.org.uk>
Cc: Linux NICS <linuxnics@mailbox.cps.intel.com>, linux-kernel@vger.kernel.org
Subject: RE: e100 doing bad things in 2.5.44.
Date: Sat, 26 Oct 2002 21:30:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, it holds bdp->isolate_lock for an incredibly long time, so that 
> might trigger this.  At least interrupts aren't disabled.
> 
> Another bug:  e100_close doesn't get the lock.

This came up earlier and we're working on getting rid of isolate_lock
altogether.  It's a bunch of complication for no real benefit, really.  

> > Oct 25 18:38:12 tetrachloride kernel:   Mem:0xfeafc000  
> > IRQ:20  Speed:0 Mbps  Dx:N/A
> 
> Cosmetic or real, that's indeed another bug...

We'll I guess no link would give you a speed of zero Mbps.  ;)

I'm inclined to strike this message line because it's 1) misleading, 2)
redundant.

-scott
