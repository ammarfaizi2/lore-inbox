Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbTGDUh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbTGDUh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:37:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3462 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266166AbTGDUh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:37:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jul 2003 22:52:21 +0200 (MEST)
Message-Id: <UTC200307042052.h64KqLA16451.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, mdharm-kernel@one-eyed-alien.net,
       torvalds@osdl.org
Subject: Re: scsi mode sense broken again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just did some re-testing, and my self-powered Zip250 and Zip750 work.
> The 750 takes a few seconds to initialize, but nothing really bad.
> What Zip do you have that doesn't work?

2.5.72 or patched 2.5.74:

<4>imm: Version 2.05 (for Linux 2.4.0)
<4>imm: Found device at ID 6, Attempting to use EPP 32 bit
<4>imm: Found device at ID 6, Attempting to use SPP
<4>imm: Communication established at 0x378 with ID 6 using SPP
<6>scsi1 : Iomega VPI2 (imm) interface
<5>  Vendor: IOMEGA    Model: ZIP 100           Rev: P.05
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<5>SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
<5>sda: Write Protect is off
<5>sda: cache data unavailable
<6> sda: sda4
<5>Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0

An unpatched 2.5.74 says

<4>IMM: returned SCSI status b8
<4>sda: test WP failed, assume Write Enabled
<3>sda: asking for cache data failed
<5>sda : READ CAPACITY failed.
<4>sda: test WP failed, assume Write Enabled
<3>Buffer I/O error on device sda, logical block 0
<6> sda: unable to read partition table

and no I/O is possible.

Andries

