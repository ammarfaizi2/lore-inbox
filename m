Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277418AbRJEPeR>; Fri, 5 Oct 2001 11:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277417AbRJEPd5>; Fri, 5 Oct 2001 11:33:57 -0400
Received: from mailrelay3.inwind.it ([212.141.54.103]:54160 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S277418AbRJEPdp>; Fri, 5 Oct 2001 11:33:45 -0400
Message-Id: <3.0.6.32.20011005173131.01dee800@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 05 Oct 2001 17:31:31 +0200
To: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>,
        <linux-kernel@vger.kernel.org>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
In-Reply-To: <Pine.LNX.4.33.0110041618450.2582-100000@chemcca18.ucsd.edu
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17.03 04/10/01 -0700, Alexei Podtelezhnikov wrote:
>Hi guys,
>
>I've already expressed my concern about using srand(1) in private e-mails.
>I think it's unscientific to use one particular random sequence. Since 
>no one checked if that matters, I changed srand(1) to srand(time(NULL)) 
>and I'm posting my results. I don't do testing of Alan or Linus's kernels, 
>but use recent Red Hat kernel. I think I've shown that it does matter.
>
>Six quick consecutive runs of modified qs on a small set of 8 million 
>integers (obviously no swap activity):
>
>> time ./a.out 8000000
>0 errors.
>24.250u 0.310s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
>0 errors.
>24.290u 0.260s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
>0 errors.
>24.300u 0.260s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
>0 errors.
>24.270u 0.300s 0:24.57 100.0%   0+0k 0+0io 116pf+0w
>0 errors.
>24.290u 0.270s 0:24.56 100.0%   0+0k 0+0io 116pf+0w
>0 errors.
>24.280u 0.280s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
>
>Apparently, no significant deviations in computing times.
>
>Six runs of modified qs on a large set of 80 million integers (a lot of 
>swapping!)
>
>> time ./a.out 80000000
>0 errors.
>261.580u 4.250s 11:09.21 39.7%  0+0k 0+0io 17379pf+0w
>0 errors.
>260.460u 3.660s 9:09.72 48.0%   0+0k 0+0io 13194pf+0w
>0 errors.
>260.620u 4.510s 10:39.80 41.4%  0+0k 0+0io 16714pf+0w
>0 errors.
>261.790u 4.150s 10:09.58 43.6%  0+0k 0+0io 16331pf+0w
>0 errors.
>260.400u 4.140s 9:23.46 46.9%   0+0k 0+0io 13722pf+0w
>0 errors.
>259.980u 3.940s 9:10.22 47.9%   0+0k 0+0io 14240pf+0w
>
>mean = 9m57s; standard deviation = 50s.
>
>Apparently, the random sequence does matter (to the Rik's algorithm at 
>least since it's in RH kernel).
>
>I wonder how big the deviation is for official and AC trees.
>Now Lorenzo's results seem inconclusive.

Yours too, as you have not compared two or more kernels yet.
You have just proved that the random sequence does matter on that
particular kernel.



-- 
Lorenzo
