Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317879AbSGPQIH>; Tue, 16 Jul 2002 12:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGPQIG>; Tue, 16 Jul 2002 12:08:06 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:35279 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id <S317876AbSGPQIG>; Tue, 16 Jul 2002 12:08:06 -0400
Mime-Version: 1.0
Message-Id: <a05111609b958efe305c4@[129.98.90.227]>
In-Reply-To: <Pine.LNX.3.95.1020715143606.232A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020715143606.232A-100000@chaos.analogic.com>
Date: Tue, 16 Jul 2002 00:29:28 -0400
To: root@chaos.analogic.com
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: Mount corrupts an ext2 filesystem on a RAM disk
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, raul@pleyades.net
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It also works okay here. Maybe, just maybe, you booted with initrd,
>but did't unmount it before you started mucking with it `umount /initrd`
>in the script below.
>

I retested the ramdisk without executing the initial umount 
instructions you proposed and saw the problem as I expected, but when 
I first ran your umount instructions and then tested again, the fsck 
problem didn't show up!

I tested this on all three of my boxes and they all behave the same.

So I guess this means there is a problem somewhere else, but I don't know what:

1) initrd really had still been mounted though df does not detect it.

2) there is no ghost initrd mounted, but merely executing bogus 
umount instructions in some unknown way prevents the problem.

If it is the first one, there are two questions: why is initrd not 
getting unmounted and why doesn't it show up in df?
If it is the second one, then what could be going on?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
