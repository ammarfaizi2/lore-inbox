Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbULGLlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbULGLlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbULGLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:41:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:56233 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261790AbULGLll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:41:41 -0500
Date: Tue, 7 Dec 2004 12:41:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andy <genanr@emsphone.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rereading disk geometry without reboot
In-Reply-To: <20041206202356.GA5866@thumper2>
Message-ID: <Pine.LNX.4.53.0412071240300.18630@yvahk01.tjqt.qr>
References: <20041206202356.GA5866@thumper2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am using linux kernel 2.6.9 on a san.  I have file systems on

(What's a SAN?)

>non-partitioned disks.  I can resize the disk on the SAN, reboot and grow
>the XFS file system those disks.  What I would like to avoid rebooting or
>even unmounting the filesystem if possible.
>
>Is there any way to get the kernel to re-read the disk geometry and change
>the information it holds without rebooting or reloading the module (which is
>as bad as a reboot in my case)?

The `fdisk` tool will spit out an ioctl() to make the kernel reread the
partition table (on normal computers, don't know about or what SAN). No need to
reboot there at least.


Jan Engelhardt
-- 
ENOSPC
