Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUBQUjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBQUjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:39:10 -0500
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:5074 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S266539AbUBQUhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:37:48 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Still have build error on 2.6.2 fc/proc/array.c
Date: Tue, 17 Feb 2004 13:37:46 -0700
Message-ID: <0A78D025ACD7C24F84BD52449D8505A15A80D4@wcosmb01.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what is the best 2.6.2 kernel code?
Thread-Index: AcPygVpyfFeoQjFiRBGXGR96w6An7QDE1zYA
From: <yiding_wang@agilent.com>
To: <smoogen@lanl.gov>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Feb 2004 20:37:47.0291 (UTC) FILETIME=[E71D86B0:01C3F595]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for everyone that replied!

Based on README and requirement of Changes in linux-2.6.2, I have updated needed utilities and other files with the following:
binnutils 2.14
e2fsprogs-1.34
module-init-tools-3.0-pre10
procps 3.1.15

Everything is installed OK.

Then compiling new 2.6.2 kernel still fails wi the following.  What is the upgrade file for this problem?

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 727 1015 1009 (parallel[ 
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 721 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2


Many thanks!

Eddei

> -----Original Message-----
> From: Stephen Smoogen [mailto:smoogen@lanl.gov]
> Sent: Friday, February 13, 2004 2:33 PM
> To: WANG,YIDING (A-SanJose,ex1)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: what is the best 2.6.2 kernel code?
> 
> 
> On Fri, 2004-02-13 at 15:24, yiding_wang@agilent.com wrote:
> > I downloaded kernel linux-2.6.2.tar.gz and patch-2.6.2.bz2  
> from kernel source.  Both files are dated 03-Feb.-2004.   
> > 
> 
> The patch file is used for patching linux-2.6.1 -> 2.6.2 and not for
> anything else. Basically you should probably do a 
> 
> /bin/rm linux-2.6.2
> tar xzvf linux-2.6.2.tar.gz
> cd linux-2.6.2
> and follow the instructions on compiling from the README.
> 
> -- 
> Stephen John Smoogen		smoogen@lanl.gov
> Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
> Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
> -- So shines a good deed in a weary world. = Willy Wonka --
> 
> 
