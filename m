Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVDPReq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVDPReq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVDPReq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 13:34:46 -0400
Received: from marvin.brothermu.net ([204.91.10.115]:401 "EHLO
	mail.brothermu.net") by vger.kernel.org with ESMTP id S262704AbVDPRen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 13:34:43 -0400
Message-ID: <42614CAF.50606@axium.net>
Date: Sat, 16 Apr 2005 13:34:39 -0400
From: "Matt M. Valites" <mval@axium.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Poor  I/O Performance with MegaRaid SATA 150-4; bug or feature?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hail List,

I've been banging my head against this for a few days, and I wanted to
see if anyone here could lend a hand.

I have the following configuration:
P4 3.x Ghz
2GB Ram;
2 x 36GB WD Raptors; in a RAID1 (sda)
2 x 74GB WD Raptor (those 10K RPM SATA drives) in a RAID1(sdb)
Two free PCI-X slots, one of which occupied by a LSI MegaRaid SATA 150-4.

The problem is I/O on either one of these RAID devices seems to
be less than half what I'm expecting.   The file system used in my testing is
XFS, and I'm running kernel 2.6.11.6.

The test I'm doing is a simple:
# time dd if=/dev/zero of=./crap.file bs=1024 count=209715
Which results in a runtime of about ~53s, in the best case, with all the
scary write cache enabled.    I've tried with deadline, and
anticipatory.  I've also tried several kernels, namely a recent 2.4, so
I could test megaraid and megaraid2, similar results.

On my desktop box, with one of these drives connected via SATA, i get
~25s, also XFS.  (2.6.11-gentoo-r6 x86_64).

Is this an expected result?  I'm seeing much higher numbers posted around the
'Net.  Most of those results are from Windows boxes.

I've uploaded my kernel config, lspci -v, and two opreports of a bonnie++ run
to: http://www.muixa.com/lkml/

Any thoughts would be appreciated.
Thanks,
--
Matt M. Valites








