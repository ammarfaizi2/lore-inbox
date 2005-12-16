Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVLPWdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVLPWdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVLPWdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:33:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59823 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932553AbVLPWdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:33:44 -0500
Date: Fri, 16 Dec 2005 23:33:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: gtkpod and Filesystem
In-Reply-To: <dnveja$i7i$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0512162329320.24996@yvahk01.tjqt.qr>
References: <20051216145234.M78009@linuxwireless.org> <dnul89$r4k$1@sea.gmane.org>
 <Pine.LNX.4.61.0512162311180.24996@yvahk01.tjqt.qr> <dnveja$i7i$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> a bug in gtkpod or the kernel (FS Panic).
>>>Maybe an FS error on your iPod? Did you try to reformat or dosfsck it?
>> Even then, the filesystem code should handle corrupt filesystems more
>> gracefully.
>
>Mh, what's "more gracefully" in the light of fs corruption?

	return -EIO;

through all instances back to userspace and keep returning EIO for all 
future requests. But let the user still umount the device.

>The driver just
>blocked write access to avoid further damage caused by writing to an
>inconsistent file system which sound perfectly reasonable to me. Writing to
>a corrupted fs could cause anything to it, depending on the corruption, so
>better act safe than sorry...

The interesting part comes when the filesystem corrupts itself
 (= the code corrupts the on-disk data), and/plus it does not 
notice quickly enough.


Jan Engelhardt
-- 
