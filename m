Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262508AbTDANFL>; Tue, 1 Apr 2003 08:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbTDANFL>; Tue, 1 Apr 2003 08:05:11 -0500
Received: from navigator.sw.com.sg ([213.247.162.11]:31739 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP
	id <S262508AbTDANFI>; Tue, 1 Apr 2003 08:05:08 -0500
From: Vladimir Serov <vserov@infratel.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Message-ID: <3E899128.2050200@infratel.com>
Date: Tue, 01 Apr 2003 17:16:24 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: NFS write got EIO on kernel starting from 2.4.19-pre4 (or -pre3 maybe)
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,
Belive or not, I've got another NFS related problem. I'm getting EIO in 
several programs (dd, make) writing relativly large file (several 
megabytes) over NFS. I've tested several kernels to find out where this 
problem was introdused. Here the list:

Good kernels (doesn't give EIO) : 2.4.18-5asp, 2.4.19, 2.4.20-pre2
Bad kernel (gives EIO): 2.4.20-pre4, 2.4.20-pre6, 2.4.20, 
2.4.21-pre5-ac3, 2.4.21-pre6
2.4.20-pre3 unfortunatly hangs on boot on my hardware.

I'm able to trigger problem by 'dd if=/dev/zero of=test bs=32k count=1024'
I'm using NFS over UDP, and this problem ccured regardless of soft or 
hard mounted fs.
There was no changes in eepro100 driver i'm using for NIC between 
2.4.20-pre2 and 2.4.20-pre4

client hardware : Intel mobo with built-in NIC , P4 2.2Ghz, 512 Mb DDR 
memory
server hardware: MSI i815ept mobo with  3Com 3c905C-TX/TX-M [Tornado] 
PIII 733Mhz , 512Mb SDRAM

client and server are on the same 100Mb hub , client is under ASP Linux 
7.3, server is under RH8.0
Unfortunatly, dd or cp problem is transient , while make (actually ar) 
gets EIO when building openh323 just every time.
I have to stick to the more recent then  2.4.20-pre2 kernel to make 
CD/DVD writer working on the other hand.
Can You  investigate this problem or give me an advise what to do myself ?

By the way , do You have any progress with nfsclient hanging in the D 
state, i've told You previously ?
Cheers, Vladimir.
