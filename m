Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUHVQzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUHVQzM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHVQzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:55:12 -0400
Received: from [213.188.213.77] ([213.188.213.77]:18079 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S268026AbUHVQzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:55:03 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Production comparison between 2.4.27 and 2.6.8.1
Date: Sun, 22 Aug 2004 18:54:57 +0200
Message-ID: <000a01c48868$c1b334e0$0600640a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <4127F7FD.5060804@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin Wrote:
> I wouldn't worry too much about hdparm measurements. If you 
> want to test the streaming throughput of the disk, run dd 
> if=big-file of=/dev/null or a large write+sync.
> 
> Regarding your worse non-RAID XFS database results, try 
> booting 2.6 with elevator=deadline and test again. If yes, 
> are you using queueing (TCQ) on your disks?

Done another test.
This time I created a 256Mb ramdisk, formatted it as ext3 and mounted as
data partition.

Results are the following:
2.6.8.1:
A)
real    0m0.437s
user    0m0.036s
sys     0m0.013s

B)
real    0m37.307s
user    0m3.212s
sys     0m1.287s


2.4.7:
A)
real    0m0.437s
user    0m0.024s
sys     0m0.010s

B)
real    0m38.180s
user    0m2.950s
sys     0m1.602s


In this case results are comparable.
What is the difference, so?
2.6 performs better reading from disk.
Avoiding PCI, SATA and disks on this test makes 2.4 and 2.6 perform in
the same way.

Hope this helps.

Massimo Cetra




