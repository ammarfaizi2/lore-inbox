Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVBIHkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVBIHkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 02:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVBIHke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 02:40:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:45782 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261799AbVBIHk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 02:40:27 -0500
Date: Wed, 9 Feb 2005 08:38:18 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       developers@melware.de
Subject: Re: [2.6 patch] drivers/isdn/hardware/eicon/: misc possible cleanups
In-Reply-To: <20050209014235.GA2978@stusta.de>
Message-ID: <Pine.LNX.4.61.0502090828550.8366@phoenix.one.melware.de>
References: <20050206003556.GK3129@stusta.de> <Pine.LNX.4.61.0502061110120.1053@phoenix.one.melware.de>
 <20050209014235.GA2978@stusta.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Adrian Bunk wrote:
> On Sun, Feb 06, 2005 at 11:18:18AM +0100, Armin Schindler wrote:
> 
> > Hi Adrian,
> 
> Hi Armin,
> 
> > thanks for the proposed patch.
> > Making the functions static is a good idea, I will check and test this.
> > Removing some functions, especially from io.* and di.* is not good. These 
> > functions are mainly used with other sub-drivers which are not part of the
> > kernel. I will check if they are some really outdated and the removals in 
> > message.c.
> 
> silly question:
> Why are these sub-drivers not included in the kernel?

These drivers are for older cards and are not fully ported to kernel 2.6. 
I never really intended to put this old stuff into kernel 2.6.
The code of io.* and di.* is common code for all supported platforms, so I
always try to reduce changes here.
Like my last patch, I will try to remove unused code in linux with a
preparser in my code-controller. So eventually the mentioned code is really
unsused and can be removed. 
I will check all this in the next days and prepare a new patch.

Armin

