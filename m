Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRLKQC4>; Tue, 11 Dec 2001 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281552AbRLKQCr>; Tue, 11 Dec 2001 11:02:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20201 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280426AbRLKQCg>; Tue, 11 Dec 2001 11:02:36 -0500
Subject: Scsi problems in 2.5.1-pre9
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 11 Dec 2001 10:07:54 +0000
Message-Id: <1008065277.25964.5.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hardware is a dual proc PII-300.  I was running LTP runalltests.sh
and it was on one of the growfiles tests when this problem occurred. 
The test hung, and I couldn't telnet into the machine or login to it,
but I could switch between VC's.  On the console, I had screenfulls of
errors like this:

Incorrect number of segments after building list
counted 11, received 7
req nr_sec 1024, cur_nr_sec 8
Incorrect number of segments after building list
counted 14, received 10
req nr_sec 1024, cur_nr_sec 8
Incorrect number of segments after building list
counted 13, received 11
req nr_sec 584, cur_nr_sec 8
Incorrect number of segments after building list
counted 2, received 1
req nr_sec 16, cur_nr_sec 8
Incorrect number of segments after building list
counted 2, received 1
req nr_sec 16, cur_nr_sec 8
(scsi0:A:5:0): Locking max tag count at 64

After doing a hard reboot ext2 made me do a manual fsck, but it seems ok
now.  I was not able to produce this error in 2.5.1-pre8.

Thanks,
Paul Larson

