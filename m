Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276429AbRJYVYZ>; Thu, 25 Oct 2001 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276411AbRJYVYU>; Thu, 25 Oct 2001 17:24:20 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:64008 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S276424AbRJYVYD>;
	Thu, 25 Oct 2001 17:24:03 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D595@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Cc: "Jens Axboe (E-mail)" <axboe@suse.de>
Subject: performance of 2.4.13pre4 with Jens blockhighmem 
Date: Thu, 25 Oct 2001 17:22:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some more performance data.

I had some problems with the megaraid portion of the patch and removed that
part of it since most of the storage was connected via the qlogicfc card.
What I measured was a maximum throughput of 125% that of the 2.4.13pre4
without the patch.  The run was also much more stable.  (No dropped packets
because of response times.)

The formula used is:

Max throughput of the 2.4.13pre4 with patch
--------------------------------------------------------------- * 100
Max throughput of the' 2.4.13pre4 w/o patch

The problem that I see is that 2.4.13preX were all really slow.  I'm seeing
less than 50% of the throughput that was seen in 2.4.5pre1 and the response
times increased by 50% in the 2.4.13pre2 time frame.  Where we were getting
1 ms response times, we now see 1.5 to 2.  This multiplicative factor grows
as the test becomes more aggressive.

The benchmark is SPEC SFS NFS benchmark testing. The filesystem is reiserfs.

I hope this information helps.

Cary
