Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289837AbSBKQtu>; Mon, 11 Feb 2002 11:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289839AbSBKQtl>; Mon, 11 Feb 2002 11:49:41 -0500
Received: from stinky.trash.net ([195.134.144.50]:20178 "HELO stinky.trash.net")
	by vger.kernel.org with SMTP id <S289837AbSBKQtY>;
	Mon, 11 Feb 2002 11:49:24 -0500
Date: Mon, 11 Feb 2002 17:49:21 +0100 (MET)
From: "Peter H. Ruegg" <lkml+nospam@incense.org>
X-X-Sender: peach@stinky.trash.net
To: linux-kernel@vger.kernel.org
Subject: Still problems with mke2fs on huge RAID-partition
In-Reply-To: <01C9A99CE9CFD511B3BB00D0B73EBB25424DC4@exchange.intern.eproduction.ch>
Message-ID: <Pine.GSO.4.42.0202111739310.10330-100000@stinky.trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

still having problems, though I'm a bit futher now.

To recall:

 - MB  Asus A7V266-E  with Onboard VIA-Controller
 - 3 x Promise Ultra100Tx2
 - 2 x 40 GB Matrox HD on ide0
 - 1 x CD-Writer on ide1
 - one 80 GB Matrox HD per channel on ide2-7
 - RedHat 7.2 with all updates applied.

I'm still trying to build a Software-RAID-5 on the 80GB-disks. What I ex-
perience is the following: On Standard-RedHat-Kernels the raid can be built,
however if I try to mke2fs, the box freezes solidly the moment it begins
writing Superblocks and Filesystem accounting.

My own kernels work happily as long as I don't try to build the software-
raid. It's possible to mke2fs each one seperately. However, when I start
mkraid (or raidstart for that matter), it takes a few seconds and then the
box freezes solidly.

This is 100% reproducable under Kernel 2.4.16, 2.4.17, 2.4.18-pre7-ac3,
2.4.18-pre9, all (except 2.4.18-pre7-ac3) with or without Andre Hedrick's
IDE-Patch.

I've been suspecting the Powersupply, but that wasn't it as well... The
BIOS of the Promisecards sets up only two of them, btw, but linux sees
them all and after Resetting the additional busses it seems(...) to work
pretty good. I've also been trying to build the RAID only over the first
two cards, to no avail as well.

Does anyone have 3 Promise-Cards working and could send me their .config?
Are there any patches besides the ide-patch I could try? Any other sugges-
tions?

Thanks for your time


Peter H. Ruegg

--8<-------------------------------------------------------------------------
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}

