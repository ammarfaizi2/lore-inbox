Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbULHAIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbULHAIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbULHAIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:08:49 -0500
Received: from postman1.arcor-online.net ([151.189.20.156]:60603 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261846AbULHAIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:08:43 -0500
Message-ID: <33103.192.168.0.5.1102457262.squirrel@192.168.0.10>
In-Reply-To: <41B5E46D.5020204@tmr.com>
References: <33560.194.39.131.40.1101824878.squirrel@noto.dyndns.org>
    <41B5E46D.5020204@tmr.com>
Date: Tue, 7 Dec 2004 23:07:42 +0100 (CET)
Subject: Re: growisofs / system load / dma setting
From: "Thomas Fritzsche" <tf@noto.de>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

I don't have X or an automounter running. I also tried to stop the running
vdr but nothing changed.
Here is the output of "vmstat 1":
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 1  1    288   5024   8720 405068    0    0     0     0 3708  1258  0 25
75  0
 1  1    288   5024   8720 405068    0    0     0     0 3711  1074  0 20
80  0
 1  1    288   5016   8728 405068    0    0     0   208 3746  1019  0 22
78  0
 0  1    288   5016   8728 405068    0    0     0     0 3673   969  0 15
85  0
 1  1    288   5016   8728 405068    0    0     0     0 3663  1049  0 24
76  0
 1  1    288   5016   8728 405068    0    0     0     0 3719  1152  2 21
77  0
 1  1    288   5016   8728 405068    0    0     0     0 3716  1114  0 18
82  0
 1  1    288   5008   8736 405068    0    0     0    80 3711  1141  0 23
77  0
 0  1    288   5008   8736 405068    0    0     0     0 3674  1033  0 19
81  0
 1  1    288   5008   8736 405068    0    0     0     0 3682  1015  4 25
71  0
 1  1    288   5008   8736 405068    0    0     0     0 3708  1012  0 21
79  0
 1  1    288   5008   8736 405068    0    0     0     0 3713  1043  0 17
83  0
 1  1    288   5000   8744 405068    0    0     0    80 3720  1011  0 29
71  0
 1  1    288   5000   8744 405068    0    0     0     0 3610  1033  1 20
79  0
 1  1    288   4680   8744 405388    0    0   320     0 2955   958  0 42
58  0
 1  1    288   4680   8744 405388    0    0     0     0 2451   881  1 50
49  0
 2  0    288   4464   8720 405656    0    0  2364     0 2562   843  0 50
50  0
 2  0    288   4208   8560 406076    0  128  6016   220  930   632  0 96 
4  0
 3  0    288   5124   8452 405268    0    0  5632     0 1048   813  3 87
10  0
 3  0    288   4276   8224 406344    0    0  5760     0 1075   818  1 91 
8  0
 3  0    288   4392   8040 406396    0    0  5640     0 1057   823  2 94 
4  0
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 4  0    288   5180   7816 405852    0    0  5636     0 1072   835  2 84
14  0
 3  0    288   4532   7760 406552    0    0  5640   144 1108   887  1 85
14  0
 3  0    288   4672   7704 406476    0    0  5636     0 1103   872  1 86
13  0
 3  0    288   4812   7676 406368    0    0  5636     0 1119   902  1 86
13  0
 4  0    288   4876   7668 406248    0    0  5640     0 1131   889  2 92 
6  0
 3  0    288   4944   7656 406256    0    0  5636     0 1092   829  9 85 
6  0
 1  0    288   4956   7664 406244    0    0  5740   140 1123   905  1 90 
9  0
 3  0    288   4980   7652 406236    0    0  5664     0 1047  2231  9 89 
2  0
 3  0    288   5000   7640 406240    0    0  5636     0 1060  2351  9 91 
0  0
 4  0    288   4876   7612 406384    0    0  5640     0 1011  2196 11 89 
0  0
 3  0    288   4776   7600 406500    0    0  5636     0 1076  1591  8 92 
0  0
 4  0    288   4768   7604 406500    0    0  5636   112 1099  1883  8 92 
0  0
 3  0    288   4932   7596 406356    0    0  5512     0 1130  2497  8 92 
0  0
 3  0    288   4808   7580 406492    0    0  5764     0 1091  1816  6 94 
0  0
 4  0    288   4684   7572 406624    0    0  5768     0 1117  2155 10 90 
0  0
 6  0    288   4584   7544 406620    0    0  5636     0 1150  1837 10 90 
0  0
 4  0    288   4592   7548 406736    0    0  5636   100 1090  1262 12 88 
0  0
 4  0    288   4596   7540 406744    0    0  5640     0 1128  1598 11 89 
0  0
 4  0    288   4600   7528 406756    0    0  5636     0 1134  1454  8 92 
0  0


This is the begin of a DVD recording as you can see the system load "si"
is going up to 80%-90%.

Thanks and regards,
 Thomas Fritzsche


>> Is this a growisofs problem or a kernel problem? What causes this
>> trouble?
>> What can I do to avoid this problems.
>
> Do you have any automounter daemon running? All the window managers are
> really bad about this, even when told not to do that, they do (under
> some conditions I haven't isolated).
>
> Try it running with X down (console mode). If the problem goes away you
> have a start, if not track the system with "vmstat 1" and post a screen
> or two.


