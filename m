Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbRAXQw2>; Wed, 24 Jan 2001 11:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRAXQwS>; Wed, 24 Jan 2001 11:52:18 -0500
Received: from mcdc-us-smtp3.cdc.gov ([198.246.97.19]:39181 "EHLO
	mcdc-us-smtp3.cdc.gov") by vger.kernel.org with ESMTP
	id <S130195AbRAXQwC>; Wed, 24 Jan 2001 11:52:02 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E8045@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: fyi megaraid problems
Date: Wed, 24 Jan 2001 11:50:54 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don't know if this has been covered/studied

datapoints I've run across re the megaraid
(scsi raid driver, american megatrends)

box: Dell PowerEdge 2300, 2 cpus, 1G RAM

hard drive setup as single drive via raid
controller

RH6.1, compiled 2.2.13, megaraid works!

RH7.0 install/upgrade breaks on megaraid
then, after forcing RH7.0 upgrade by hand 
 (completely snuffed up with all updates as of jan 23 am ...)
RH7.0 kernel (out of the rpm box 686 smp) breaks on megaraid
RH7.0 2.2.16 kernel source from rpm 
 compiled using 2.2.13 .config file
 and make oldconfig generates kernel that
 breaks on megaraid (used RH provided
 scripts to compile with kgcc)
2.2.18 kernel (kernel.org) compiled with gcc on RH7.0
 breaks on megaraid during boot

BUT! 2.4.1pre10 (kernel.org), compiled with gcc on RH7.0
 the megaraid driver works again!

I was surprised that even 2.2.18 breaks
then 2.4.1pre10 works, given RH's alliance
with Dell.

I compiled a 2.4.0 and set it up in
lilo.conf but haven't tried booting to it.

If it's useful to anyone, now that I have
a good booting kernel I could recompile the
old 2.2.13 setup and see whether the problem
is due to a bad compiler env in RH7.0 or
due to a bad megaraid module (i.e. if kernel
that works fine now compiled under 6.1 
breaks when recompiled under 7.0 then bug
is in the RH7.0 compiler env; else bug is
in megaraid shipped with 2.2.16, 2.2.18)

Let me know if someone needs a datapoint.

Heitzso
xxh1@cdc.gov
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
