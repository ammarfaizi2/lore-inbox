Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRFDOw4>; Mon, 4 Jun 2001 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264300AbRFDOse>; Mon, 4 Jun 2001 10:48:34 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:16443 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S264299AbRFDOsS>; Mon, 4 Jun 2001 10:48:18 -0400
Date: Mon, 4 Jun 2001 16:48:29 +0200 (SAST)
From: Marcin Kowalski <kowalski@datrix.co.za>
To: linux-aacraid-devel@Dell.com
cc: linux-kernel@vger.kernel.org
Subject: Performance Bottleneck 2.4.4+root-reiserfs?? - AAcRaid-Reiserfs??.
Message-ID: <Pine.LNX.4.10.10106041640010.29346-100000@webman.medikredit.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

AS I type I am running a simple:
cat /proc/loadavg ; time dd if=/dev/zero of=test.fil bs=32768; cat
/proc/loadavg
on a HP Netserver 2000 with 2xPiii + 1gig ram + 100gig Raid5 (85gig).
I am running suse7.0 with kernerl 2.4.4 patched for AACraid Device 

I have the privelage of having two such identical servers. The only
difference is the one that just peaked with a 14 load average and is
transfering +- 1.5mb/s(xovsiew) has its' root filesystem as reiserfs and
the other  uses ext2.
The raid arrays are both however reiserfs and the same size with the same
hard drives. Except on the ext2 fs root the performance to write 2gigs
is
:real    0m49.766s
user    0m0.270s
sys     0m27.750s
1.22 1.43 1.49 1/49 7038

While on the reiserfs root it is still busy after a number of minutes.

Does read /dev/zero in a reiserfs fs slow things down SO much or is it a
Hardware/Driver fault??? What is going on ??

The reiserfs root just finished with:
real    12m30.025s
user    0m0.190s
sys     2m41.240s
5.79 7.66 4.78 1/96 29911

or 15 times slower on Identical hardware.... is this a BUG/feature of
reiserfs root....

Thanks for any and all replies
 marCin



-------------------------------------
#    Marcin Kowalski                # 
      On_Linux Developer.
       ->Datrix Solutions.<-
	
	Tel. 770-6146
#	Cel. 082-400-7603           #
-------------------------------------

