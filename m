Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUEWTY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUEWTY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUEWTY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:24:28 -0400
Received: from web90009.mail.scd.yahoo.com ([66.218.94.67]:36490 "HELO
	web90009.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S263448AbUEWTYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:24:25 -0400
Message-ID: <20040523192425.87591.qmail@web90009.mail.scd.yahoo.com>
Date: Sun, 23 May 2004 12:24:25 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Slow down across kernels
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please cc me as I am not on this mailing list.

I have an issue with the 2.6 kernels that I am unable
to understand and correct.

I have a custom binary that I have used to compile
across different kernel versions and I am getting
vildly different numbers:
(as reported by time):

2.4.21-9  ~45s
2.4.22    ~55s
2.6.1     ~3m.40s
2.6.2     ~4m.00
2.6.3     ~4m.00
2.6.6     ~3m.15s
2.6.6-mm4 ~1m.30s

It is most shocking how much more time is spent in
user/kernel in comparsion:
2.4.21-9

5.09user 9.04system 0:43.79elapsed 32%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (7378946major+1139090minor)pagefaults
0swaps

VS.

2.6.6-mm4

13.06user 23.80system 1:32.00elapsed 40%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7537027minor)pagefaults
0swaps


The system is AMD Opteron 246 w/12G RAM and broadcom
Ge.  To rule out network issues, I have moved the
files to the local files system, ext2 on a UW320
drive.

I have also tested this on a dual Xeon 3.06GHz w/8G
RAM ge with very similar results in differences across
the kernels.

strace and make -d show no major differences.

Kernels are built with gcc323/340 and bintuils
2.13.2.1.

Could someone help me understand what is at issue
here?

Thank you and appreciate the help.
Phy





	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
