Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBVTpZ>; Thu, 22 Feb 2001 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129131AbRBVTpO>; Thu, 22 Feb 2001 14:45:14 -0500
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:23497 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S129129AbRBVTpC>; Thu, 22 Feb 2001 14:45:02 -0500
Posted-Date: Thu, 22 Feb 2001 20:44:54 +0100 (MET)
Date: Thu, 22 Feb 2001 20:44:27 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200102221944.UAA03298@db0bm.ampr.org>
To: xxh1@cdc.gov
Subject: trouble with 2.4.2 just released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heitzso,

>On the other box I have yet to get a
>successful build (using a .config that
>runs 2.4.2-pre4 fine).  ld complains
>about a missing binary file.

>ld: cannot open binary: no such file or directory

ld is not complaining about a missing file.

The problem is with the version of ld you use. Some versions are using 
ld --oformat and other versions ld -oformat

This is quite a recent issue. So check the version of you linker.

You can solve the problem changing :
./arch/i386/boot/Makefile:      $(LD) -Ttext 0x0 -s -oformat binary -o $@ $<
to                                                  --oformat 

I think you hav not done any mistake, but the latest Debian (unstable) version
of ld seems not to be right.

I think this will works.

---------
Best Regards 

		Jean-Luc
