Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLHRIR>; Sun, 8 Dec 2002 12:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLHRIR>; Sun, 8 Dec 2002 12:08:17 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:34056 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261375AbSLHRIQ>; Sun, 8 Dec 2002 12:08:16 -0500
X-WebMail-UserID: rtilley
Date: Sun, 8 Dec 2002 12:15:57 -0500
From: rtilley <rtilley@vt.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, GertJan Spoelman <kl@gjs.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00002964
Subject: RE: *FIXED* lilo append mem problem in 2.4.20
Message-ID: <3E002B92@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>===== Original Message From Alan Cox <alan@lxorguk.ukuu.org.uk> =====
>On Sun, 2002-12-08 at 11:02, GertJan Spoelman wrote:
>>         append="mem=exactmap mem=640K@0 mem=319M@1M"
>> to get the kernel to see all the memory.
>> So probably you can get it working again with:
>>         append="mem=exactmap mem=640K@0 mem=1023M@1M"
>> Maybe you also could do directly: exactmap mem=1024M@0
>> or 1G@0, but I haven't tried that yet.
>> It seems the mem parameter now only can be used to limit the amount of 
memory
>> used by the kernel.
>
>Without exactmap yes (fixed in 2.4.19 I believe). Also on many compaqs
>you can set the OS in the BIOS to "unixware" and get sane results

append="mem=exactmap mem=640K@0 mem=1023M@1M" solved the memory issue in RH's 
latest kernel (2.4.18-18.7.xsmp) and in (2.4.20smp-ac1). However, ac1 only 
uses ~900MB whereas RH uses all of the RAM, but I think that's because I 
turned highmem of when building ac1.

This answers several questions that I had about RH's last two releases (7.3 & 
8.0). Neither release would install on this server, each would end with a "Not 
enough memory to install" right when beginning the installation. When I told 
the installer to do "linux mem=1024M" the install would progress a bit further 
before giving a kernel panic about being unable to mount the root filesystem.

I'm tempted to go back and try the above mentioned append to see if that will 
make one of the newer relesases install.

Thanks to all for the help.

Brad


