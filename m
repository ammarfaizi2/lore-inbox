Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUHDJUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUHDJUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUHDJUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:20:01 -0400
Received: from aun.it.uu.se ([130.238.12.36]:60056 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262114AbUHDJTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:19:54 -0400
Date: Wed, 4 Aug 2004 11:19:47 +0200 (MEST)
Message-Id: <200408040919.i749JlcY001509@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, sezeroz@ttnet.net.tr
Subject: Re: updated gcc-3.4 patches for 2.4.27-rc4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2004 01:25:26 +0300, O.Sezer wrote:
> > 
>http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc34-misc-fixes-2.4.27-rc4
>
>Does /drivers/usb/gadget/net2280.c line 794 not need the same
>change for min() ?

No. The min() that was changed had an argument that was a
bitfield in a struct. min() uses typeof, but typeof (like
sizeof) doesn't work on bitfields.

The arguments to the min() at line 794 are plain variables
or struct fields. They don't have any problem with typeof.

/Mikael
