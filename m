Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUJJRc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUJJRc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 13:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUJJRcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 13:32:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:191 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268378AbUJJRcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 13:32:20 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
In-Reply-To: <4169293B.3020502@comcast.net>
References: <41677E4D.1030403@mvista.com>  <4169293B.3020502@comcast.net>
Content-Type: text/plain
Message-Id: <1097429214.1427.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 10 Oct 2004 13:26:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 08:21, John Richard Moser wrote:

> Does any of this 'work' on x86_64 yet?  I heard that Ingo's voluntary
> pre-empt was x86 only and didn't work on amd64; this stuff's kinda new,
> does it work outside x86 yet?
> 
> I'd like to see what these kinds of things do.  :)

The VP patches currently work on x86, x64, amd64, and ppc AFAIK.  As
stated in the docs, the MontaVista stuff is x86 only right now.

My tests show the worst case latency with the MontaVista patches is
about twice that of the VP patches.  Probably due to debug overhead and
a bug or two.  But, as expected, the average case latency is _much_
better.

Here's the top of the VP histogram, delay is in usecs:

Delay   #
0       5764433
1       3154867
2       461521
3       332445
4       403847
5       320120
6       237955
7       152418
8       94274
9       66496
10      52976
11      44605
12      38437
13      31620
14      27816
15      26845
16      23743
17      20648
18      21611
19      24853
20      30352
21      50046
22      101989
23      24843
24      28829
25      56247
26      42408
27      28228
28      20773
29      19521

Here's the top of the Mvista histogram:

Delay   #
0       6771692
1       26
2       29
3       12
4       15
5       15
6       15
7       18
8       19
9       10
10      15
11      10
12      19
13      12
14      15
15      11
16      13
17      13
18      11
19      13
20      12
21      9
22      11
23      13
24      17
25      10
26      9
27      11
28      8
29      12

Lee

