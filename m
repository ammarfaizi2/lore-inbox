Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269669AbRHIDmZ>; Wed, 8 Aug 2001 23:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269670AbRHIDmP>; Wed, 8 Aug 2001 23:42:15 -0400
Received: from 168-215-193-75.dslindiana.com ([168.215.193.75]:3855 "HELO
	avenir.dhs.org") by vger.kernel.org with SMTP id <S269669AbRHIDmC>;
	Wed, 8 Aug 2001 23:42:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: John Madden <weez@freelists.org>
To: linux-kernel@vger.kernel.org
Subject: oopses on 2.2.19 under load, mylex raid
Date: Wed, 8 Aug 2001 22:38:07 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0108082238077N.00173@weez>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm suspecting this to be a hardware issue, but I can't pin it down, and 
I'm hoping someone here might be able to help.  The system's a new 
built-from-scratch, so I guess the problem could be any of the components. 
 The system oopses *hard* under heavy load (make -j64 bzImage) pretty 
consistently.

Hardware: 512mb PC133, single pIII/800EB on a dual Tyan S2507, Mylex 170LP 
(DAC960) RAID controller on 4 18gig disks.  (Patched with Zubkoff's DAC960 
patch, version 2.2.10 for kernel 2.2.18)

I've swapped the RAM around and with some from a known-good system and I 
still get the crashes.  They're generally so hard that I can't scroll back 
to copy anything from the screen.  What I do get are lines like this one: 

[<c010f73c>] [<c012798e>] [c011c1cc>]...

repeating for at least a screen full, then:

Code: 39 73 74 75 2d c7 43 50 11 00 00 00 ff 83 dc 04 00 00 a1 b0

One oops that wasn't hard enough to take out the entire system looked like 
this: 

kmem_free: Bad obj addr (objp=dbad0220, name=vm_area_struct)
Unable to handle kernel NULL pointer dereference at virtual address 
00000000
current->tss.cr3=00101000, %%crs = 00101000
*pde = 00000000

Any ideas? 

Thanks,
  John


-- 
# John Madden  weez@freelists.org ICQ: 2EB9EA
# FreeLists, Free mailing lists for all: http://www.freelists.org
# UNIX Systems Engineer, Ivy Tech State College: http://www.ivy.tec.in.us
# Linux, Apache, Perl and C: All the best things in life are free!
