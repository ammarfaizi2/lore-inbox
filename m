Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312518AbSCUVuW>; Thu, 21 Mar 2002 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312516AbSCUVuL>; Thu, 21 Mar 2002 16:50:11 -0500
Received: from cpe.atm0-0-0-209183.0x3ef29767.boanxx7.customer.tele.dk ([62.242.151.103]:24540
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S312515AbSCUVt7>; Thu, 21 Mar 2002 16:49:59 -0500
Date: Thu, 21 Mar 2002 22:49:57 +0100
Message-Id: <200203212149.g2LLnv304455@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.7] initrd issue
In-Reply-To: <01a801c1d117$da899ff0$0201a8c0@WITEK>
From: Henrik Storner <henrik@hswn.dk>
X-Newsreader: NN version 6.5.6 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adasi@kernel.pl wrote:

>I was trying to use 2.5.7 with initrd. I checked almost all configuration
>options, but it's still loading RAM-Disk in one line (ext2 filesystem
>detected etc.) and 'freeing Xkb initrd memory' in the next one.

You are not alone. AFAICT, initrd is broken in 2.5.x - it fails
to mount to ramdisk unless you pass "root=/dev/ram0", and if you
do that, then it fails to switch to the real root-disk once 
/linuxrc has executed from the ramdisk. At least, that was my 
experience when trying it in 2.5.6 and 2.5.7.

The very same initrd-file worked fine with 2.4.18.
-- 
Henrik Storner <henrik@hswn.dk> 

