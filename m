Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSFLIN6>; Wed, 12 Jun 2002 04:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSFLIN5>; Wed, 12 Jun 2002 04:13:57 -0400
Received: from daimi.au.dk ([130.225.16.1]:64331 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317667AbSFLIN4>;
	Wed, 12 Jun 2002 04:13:56 -0400
Message-ID: <3D0702C1.81C1E350@daimi.au.dk>
Date: Wed, 12 Jun 2002 10:13:53 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Allan Sandfeld <linux@sneulv.dk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206031025400.30424-100000@mail.pronto.tv> <200206041311.03631.linux@sneulv.dk> <3CFCB7D1.5A09615E@daimi.au.dk> <200206041558.12209.linux@sneulv.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Sandfeld wrote:
> 
> I just looked at it. It is possible allright and the diagram looks ok.
> 
> If you have 3 disks A,B and C the parity is calculated by dividing the diskw
> into typical lines, in this example I use 3 like they use on the diagram. We
> then have a parity per line and one per disk. You can only regenerate one
> block per parity, but since you have two full independ parities you can
> replace any two.
> 
>   A1 B1 C1 P1 (P1 = A1^B1^C1)
>   A2 B2 C2 P2
>   A3 B3 C3 P3
>   PA PB PC
>  (PA=A1^A2^A3)
> 
> As you can see if you wish to chech the parity for one read line(eg.A1-C1),
> you can check directly against the horizontal parity P1. But if you wish to
> check the horizontal parity you need to read the entire diskarray!

I don't think I got that one. How many disks would you use, and
how would you distribute the above fields across the disks? If
you put each column on a disk you can handle any two lost
blocks, but not two lost disks. Or would you use a total of 15
disks? Or do you have some way of placing them on 5 disks with
3 blocks on each disk?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
