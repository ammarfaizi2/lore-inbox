Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSLHDVU>; Sat, 7 Dec 2002 22:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSLHDVU>; Sat, 7 Dec 2002 22:21:20 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:7439 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265134AbSLHDVR>; Sat, 7 Dec 2002 22:21:17 -0500
X-WebMail-UserID: rtilley
Date: Sat, 7 Dec 2002 22:28:56 -0500
From: rtilley <rtilley@vt.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002964
Subject: lilo append mem problem in 2.4.20
Message-ID: <3DFDE59F@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Compaq proliant 5000 4 way Pentium Pro with 1 GB RAM only uses 12 to 13 MB of 
RAM when I use kernel 2.4.20 with ac1 patch even when I do append="mem=1024" 
in /etc/lilo.conf

RH 7.2 is the distro and its default kernel (2.4.7-10smp), works flawlessly 
with the mem append, it sees and uses all the RAM. But, their latest kernel 
2.4.18-18.7.xsmp fails to use the RAM as well; it too only sees 12 to 13 MB... 
this is why I tried the kernel.org kernel.

I used RH's 686-smp kernel config file to build the 2.4.20-ac1 kernel. I 
turned High Mem support off as I don't think 1 GB is high mem... is it? Anyone 
know how I can use all of the RAM?

Here's the lines from /var/log/messages for each kernel:

2.4.20smp-ac1 = Dec  4 13:44:48 localhost kernel: Memory: 12700k/16384k 
available (1396k kernel code, 3168k reserved, 102k data, 240k init, 0k 
highmem)

2.4.18-18.7.xsmp = Memory: 13156k/16384k available (1269k kernel code, 2712k 
reserved, 90k data, 220k init, 0k highmem)

2.4.7-10smp = Memory: 1026788k/1048576k available (1396k kernel code, 20376k 
reserved, 102k data, 240k init, 131072k highmem)

Thanks a bunch,

Brad

