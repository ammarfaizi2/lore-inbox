Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283708AbRLRCXq>; Mon, 17 Dec 2001 21:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283714AbRLRCXh>; Mon, 17 Dec 2001 21:23:37 -0500
Received: from [209.247.255.130] ([209.247.255.130]:24507 "HELO
	raptor.alexa.com") by vger.kernel.org with SMTP id <S283708AbRLRCXX>;
	Mon, 17 Dec 2001 21:23:23 -0500
Message-ID: <A6CFEF730CCE38449F1774A6B5D62B0C031964@shockG.archive.alexa.com>
From: Guolin Cheng <Guolin@alexa.com>
To: "'ebiederman@lnxi.com'" <ebiederman@lnxi.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Etherboot-users] 1G memory limit and Etherboot
Date: Mon, 17 Dec 2001 18:22:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Guolin Cheng [mailto:Guolin@alexa.com]
Sent: Monday, December 17, 2001 6:09 PM
To: 'ebiederman@lnxi.com'
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Etherboot-users] 1G memory limit and Etherboot


hi, Eric,

 I tried a few days ago, using etherboot 5.0.2, mknbi 1.2.6 with different
--rdbase options, but all failed. The kernel is 2.4.13, the initrd is around
64M. 

 The netbooted client is a 1.5G memory HP Vectra 420. It can successfully
netbooted with 512M memory. But can not boot when memory is added to 1024M
and 1.5G.

 The error prompt is something like:

	Kernel panic: VFS: Unable to mount root fs on 01:00

 I'm using Official kernel 2.4.13, the base system is RedHat 7.1 on HP
vectra 420.

 The commands I used to create the tagged images is:

 /usr/bin/mknbi-linux --output=./kernel.test.0540 --ip=dhcp
--rdbase=0x5b000000 --rootdir=/dev/ram0 --append="idebus=66 ide0=ata66
ide1=ata66 ro" bzImage initrd

 I also tried options, --rdbase=top/asis/0x00300000, all can failed with the
same above problem.

 At last I use local hard disk boot, with the same kernel (4G high memory
option enabled), it can boot successfully, then I tried to see the memory
mapping, and get the following information:


arc251.alexa.com guolin 64% cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8800-000c9fff : Extension ROM
000ca000-000cdfff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
  00100000-002794af : Kernel code
  002794b0-002efd17 : Kernel data
5fff0000-5fff7fff : ACPI Tables
5fff8000-5fffffff : ACPI Non-volatile Storage
d7a00000-dfafffff : PCI Bus #01
  d8000000-dbffffff : PCI device 1002:5446 (ATI Technologies Inc)
dfb00000-dfbfffff : PCI Bus #02
dfd00000-dfdfffff : PCI Bus #01
  dfdfc000-dfdfffff : PCI device 1002:5446 (ATI Technologies Inc)
dfe00000-dfefffff : PCI Bus #02
  dfeff000-dfefffff : Intel Corporation 82820 (ICH2) Chipset Ethernet
Controller
    dfeff000-dfefffff : eepro100
e0000000-e3ffffff : Intel Corporation 82845 845 (Brookdale) Chipset Host
Bridge
fff00000-ffffffff : reserved


 Please suggest which method, I can try to netboot the machine. Thanks a
lot.


 Yours sincerely,
 Guolin Cheng



 

-----Original Message-----
From: Guolin Cheng 
Sent: Thursday, November 08, 2001 1:32 PM
To: Ops
Subject: FW: [Etherboot-users] 1G memory limit and Etherboot




-----Original Message-----
From: ebiederman@lnxi.com [mailto:ebiederman@lnxi.com]
Sent: Thursday, November 08, 2001 11:17 AM
To: Christopher Fowler
Cc: Etherboot-users
Subject: Re: [Etherboot-users] 1G memory limit and Etherboot


"Christopher Fowler" <cfowler@outpostsentinel.com> writes:

> How do I specify that at boot?

It depends on what you are doing.  With mnknbi --rdbase.
With other bootloaders it varies.  The easy solution is to get
a newer kernel.  

Eric


_______________________________________________
Etherboot-users mailing list
Etherboot-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/etherboot-users
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
