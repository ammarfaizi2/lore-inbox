Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTH1Ism (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTH1Irz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:47:55 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:13220 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S263856AbTH1ISM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:18:12 -0400
Date: Thu, 28 Aug 2003 10:18:10 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Chris Cheney <ccheney@debian.org>
cc: linux-kernel@vger.kernel.org, <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: HPT372 2.344 slow drive issue
In-Reply-To: <20030827203454.GA1492@cheney.cx>
Message-ID: <Pine.LNX.4.44.0308281009240.24608-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Chris Cheney wrote:

> I have a Soyo P4I875P motherboard that has a HPT372 chip with bios 2.344
> The hard drive on the controller is a Maxtor DiamondMax Plus 9 200GB. I
> have tested the drive on ICH5 and it does around 48-52MB/s but on HPT372
> it does ~ 9MB/s. This still shows up on 2.6.0-test4-bk2 and did on 2.4.x
> but I haven't tested on 2.4 for several weeks.

I reported a similar issue some weeks ago (Abit K7D-RAID, integrated
HPT372 IDE controller), I played with 2.4.22-pre10 for a while. With the
opensource HPT driver, I reached good speed sometimes (two ATA drives were
connected to the HPT, one drive on each channel), but not reliable - after
a reboot, the md synchronisation between the two drives went down to
1MB/s... The HPT driver uses the drives as SCSI drives, so it's a little
painful to switch between the kernel and the HPT driver (initrd, mdadm,
and so on...). Finally I gave up, and disabled the HPT controller in the
system BIOS. Maybe the problem is a simple IDE autotune problem, I don't
know.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

