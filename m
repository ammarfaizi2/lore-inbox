Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRJKIpv>; Thu, 11 Oct 2001 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRJKIpl>; Thu, 11 Oct 2001 04:45:41 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:47288 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S273870AbRJKIpU>; Thu, 11 Oct 2001 04:45:20 -0400
Message-Id: <3.0.6.32.20011011104635.01e9bea0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 11 Oct 2001 10:46:35 +0200
To: Rik van Riel <riel@conectiva.com.br>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: [CFT][PATCH] smoother VM for -ac
Cc: <kernelnewbies@nl.linux.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.33L.0110101710150.26495-100000@duckman.distro.c
 onectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17.25 10/10/01 -0300, Rik van Riel wrote:
>Please test this patch and tell Alan and me how it works for
>you and whether there are loads where the system performs
>worse with this patch than without...

qsbench results,


Linux-2.4.10-ac9:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.370u 2.560s 3:17.94 37.3%    0+0k 0+0io 11773pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.760u 3.170s 4:02.93 30.8%    0+0k 0+0io 15487pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.090u 3.080s 4:07.94 29.9%    0+0k 0+0io 15856pf+0w
kswapd CPU time: 0:23


Linux-2.4.10-ac9 + Rik's smooth patch:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.090u 6.260s 3:21.65 38.3%    0+0k 0+0io 12868pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
72.460u 6.030s 3:58.10 32.9%    0+0k 0+0io 14637pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.630u 7.400s 4:00.86 32.8%    0+0k 0+0io 14894pf+0w
kswapd CPU time: 0:21



-- 
Lorenzo

