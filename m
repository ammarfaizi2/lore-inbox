Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263943AbRFMTK6>; Wed, 13 Jun 2001 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbRFMTKj>; Wed, 13 Jun 2001 15:10:39 -0400
Received: from [213.96.124.18] ([213.96.124.18]:13806 "HELO dardhal")
	by vger.kernel.org with SMTP id <S263943AbRFMTKh>;
	Wed, 13 Jun 2001 15:10:37 -0400
Date: Wed, 13 Jun 2001 21:11:34 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3
Message-ID: <20010613211133.A2234@dardhal.mired.net>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.31.0106121836030.1253-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12 June 2001, at 18:42:45 -0700,
Linus Torvalds wrote:

> 
> User-noticeable things: if you are tired of not being able to NFS-export
> your reiserfs tree, this should make you happy.
> 
> VM tuning has also happened, with Rik van Riel, Mike Galbraith, Marcelo
> Tosatti and Andrew Morton all doing various tweaks. Give it a whirl.
> 
Here is my rather simple VM stressing test. Just opening some applications
on the machine I use every day. Tested with 2.4.4 and 2.4.6-pre3.

Machine OFF. Power ON. Some processes running in the background, but iddle
(process list available on request, should it matters). Each section shows
output from "free" with additional applicatons started. Once KDE, Mozilla,
Konqueror and StarOffice are loaded, they are closed in the reverse order
as the were started.

------------------------------------------------------------------
Linux joseluis 2.4.4 #1 lun abr 30 12:02:46 CEST 2001 i686 unknown
------------------------------------------------------------------

Just booted
-----------
             total       used       free     shared    buffers     cached
Mem:        127124      30788      96336          0       3392      12360
-/+ buffers/cache:      15036     112088
Swap:       128516          0     128516

+ KDE 2.1.1 + rxvt
------------------
             total       used       free     shared    buffers     cached
Mem:        127124      85276      41848          0       5924      39656
-/+ buffers/cache:      39696      87428
Swap:       128516          0     128516

+ Konqueror (about:) + Mozilla 0.9.1 (www.engardelinux.com)
-----------------------------------------------------------
             total       used       free     shared    buffers     cached
Mem:        127124     125620       1504          0        524      45896
-/+ buffers/cache:      79200      47924
Swap:       128516      49072      79444

+ StarOffice 5.2 (ThreeDimensions.sdd)
--------------------------------------
             total       used       free     shared    buffers     cached
Mem:        127124     125656       1468          0        592      71964
-/+ buffers/cache:      53100      74024
Swap:       128516     104084      24432

+ Konqueror (about:) + Mozilla 0.9.1 (www.engardelinux.com)
-----------------------------------------------------------
             total       used       free     shared    buffers     cached
Mem:        127124     102812      24312          0        780      73900
-/+ buffers/cache:      28132      98992
Swap:       128516     102272      26244

KDE 2.1.1 + rxvt
----------------
             total       used       free     shared    buffers     cached
Mem:        127124     114660      12464          0       1176      98232
-/+ buffers/cache:      15252     111872
Swap:       128516      51068      77448

Back to the start
-----------------
             total       used       free     shared    buffers     cached
Mem:        127124     124100       3024          0       2692     110980
-/+ buffers/cache:      10428     116696
Swap:       128516      47972      80544

swapoff -a
----------
7 seconds, machine responsive

             total       used       free     shared    buffers     cached
Mem:        127124      91152      35972          0       2888      68640
-/+ buffers/cache:      19624     107500
Swap:            0          0          0


-----------------------------------------------------------------------
Linux joseluis 2.4.6-pre3 #1 mié jun 13 11:22:51 CEST 2001 i686 unknown
-----------------------------------------------------------------------

Just booted
-----------
             total       used       free     shared    buffers     cached
Mem:        127120      32108      95012          0       1468      14908
-/+ buffers/cache:      15732     111388
Swap:       128516          0     128516

KDE 2.1.1 + rxvt
----------------
             total       used       free     shared    buffers     cached
Mem:        127120      85316      41804          0       3036      42464
-/+ buffers/cache:      39816      87304
Swap:       128516          0     128516

+ Konqueror (about:) + Mozilla 0.9.1 (www.engardelinux.com)
-----------------------------------------------------------
             total       used       free     shared    buffers     cached
Mem:        127120     124804       2316          0        356      69264
-/+ buffers/cache:      55184      71936
Swap:       128516      59236      69280

+ StarOffice 5.2 (ThreeDimensions.sdd)
--------------------------------------
             total       used       free     shared    buffers     cached
Mem:        127120     124308       2812          0       1408      88592
-/+ buffers/cache:      34308      92812
Swap:       128516     109104      19412

+ Konqueror (about:) + Mozilla 0.9.1 (www.engardelinux.com)
-----------------------------------------------------------
             total       used       free     shared    buffers     cached
Mem:        127120     104168      22952          0       1488      87884
-/+ buffers/cache:      14796     112324
Swap:       128516     104516      24000

KDE 2.1.1 + rxvt
----------------
             total       used       free     shared    buffers     cached
Mem:        127120     106760      20360          0       1664      91188
-/+ buffers/cache:      13908     113212
Swap:       128516      35896      92620

Back to the start
-----------------
             total       used       free     shared    buffers     cached
Mem:        127120     103584      23536          0       1896      92168
-/+ buffers/cache:       9520     117600
Swap:       128516      22652     105864

swapoff -a
----------
4 seconds, machine responsive

             total       used       free     shared    buffers     cached
Mem:        127120      96656      30464          0       2020      75532
-/+ buffers/cache:      19104     108016
Swap:            0          0          0


Hope it helps.

--
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

