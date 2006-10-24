Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWJXRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWJXRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbWJXRBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:01:08 -0400
Received: from ns1.heckrath.net ([213.239.192.68]:44996 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S1030434AbWJXRBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:01:06 -0400
Date: Tue, 24 Oct 2006 19:01:04 +0200
From: Sebastian =?ISO-8859-15?Q?K=E4rgel?= <mailing@wodkahexe.de>
To: Sebastian Kemper <sebastian_ml@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Radeon DRI, mtrr overlaps, wrong RAM value
Message-Id: <20061024190104.58d6b964.mailing@wodkahexe.de>
In-Reply-To: <20061015013824.GA26893@section_eight>
References: <20061015013824.GA26893@section_eight>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I get the following warnings once my X server starts:
> 
> mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
> mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
> mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
> mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
> mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000

Same here:

mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x4000000
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x4000000
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x4000000

> In Xorg.0.log I get these warnings:
> 
> (WW) RADEON(0): DRI init changed memory map, adjusting ...
> (WW) RADEON(0):   MC_FB_LOCATION  was: 0xd7ffd000 is: 0xd7ffd000
> (WW) RADEON(0):   MC_AGP_LOCATION was: 0xffffffc0 is: 0xe07fe000
> (**) RADEON(0): GRPH_BUFFER_CNTL from 20205c5c to 203e5c5c

XOrg Version: 6.8.2: No such messages here.

> /proc/mtrr holds these values:
> reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
> reg01: base=0xe0000000 (3584MB), size=  32MB: write-combining, count=2
> reg02: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1

reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
reg05: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=2

Kernel: 2.6.18.1

take care,
sebastian
