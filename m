Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLYHH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 02:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTLYHH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 02:07:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33805 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263891AbTLYHH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 02:07:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: md: RAID-6 patch available for testing
Date: 24 Dec 2003 23:07:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bse2c7$viq$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Already announced to linux-raid, but I thought it might get wider
distribution in this list.]

For those that don't know, I've been working on adding RAID-6 (dual
failure recovery) to the md system for a while.  It started out as a
project because the math was interesting, and Penguin Computing for
donated a very much needed test system (thanks!)

Well, at least I have a piece of code that passes my relatively simple
functionality tests.  Still, that's news, and this is the first RAID-6
snapshot that isn't *known* to be broken :)

I can at least mount filesystems, read and write data, reboot the
system and have the data still there, with 1 or 2 disks lost, and do a
reconstruction once the drives are added back in.

New development snapshot at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/raid6-20031224c-experimental.tar.gz

Please test it out and let me know how badly it sucks :)

At some point I'll try to run some benchmarks.  There is also a lot of
optimization still to be done.

       -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
