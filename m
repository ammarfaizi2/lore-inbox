Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279653AbRJYA0A>; Wed, 24 Oct 2001 20:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279658AbRJYAZv>; Wed, 24 Oct 2001 20:25:51 -0400
Received: from inje.iskon.hr ([213.191.128.16]:33008 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S279653AbRJYAZf>;
	Wed, 24 Oct 2001 20:25:35 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.21.0110241225560.2593-100000@freak.distro.conectiva>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 25 Oct 2001 02:25:45 +0200
In-Reply-To: <Pine.LNX.4.21.0110241225560.2593-100000@freak.distro.conectiva> (Marcelo Tosatti's message of "Wed, 24 Oct 2001 12:26:36 -0200 (BRST)")
Message-ID: <dnlmi0pnue.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On 24 Oct 2001, Zlatko Calusic wrote:
> 
> > P.S. BTW, 2.4.13 still has very unoptimal writeout performance and
> >      andrea@suse.de is redirected to /dev/null. <g>
> 
> Zlatko,
> 
> Could you please show us your case of bad writeout performance ? 
> 
> Thanks
> 

Sure. Output of 'vmstat 1' follows:


 1  0  0      0 254552   5120 183476   0   0    12    24  178   438 2  37  60
 0  1  0      0 137296   5232 297760   0   0     4  5284  195   440 3  43  54
 1  0  0      0 126520   5244 308260   0   0     0 10588  215   230 0   3  96
 0  2  0      0 117488   5252 317064   0   0     0  8796  176   139 1   3  96
 0  2  0      0 107556   5264 326744   0   0     0  9704  174    78 0   3  97
 0  2  0      0  99552   5268 334548   0   0     0  7880  174    67 0   3  97
 0  2  0      0  89448   5280 344392   0   0     0  9804  175    76 0   4  96
 0  1  0      0  79352   5288 354236   0   0     0  9852  176    87 0   5  95
 0  1  0      0  71220   5300 362156   0   0     4  7884  170   120 0   4  96
 0  1  0      0  63088   5308 370084   0   0     0  7936  174    76 0   3  97
 0  2  0      0  52988   5320 379924   0   0     0  9920  175    77 0   4  96
 0  2  0      0  43148   5328 389516   0   0     0  9548  174    97 0   4  95
 0  2  0      0  35144   5336 397316   0   0     0  7820  176    73 0   3  97
 0  2  0      0  25172   5344 407036   0   0     0  9724  188   183 0   4  96
 0  2  1      0  17300   5352 414708   0   0     0  7744  174    78 0   4  96
 0  1  0      0   7068   5360 424684   0   0     0  9920  175    93 0   3  97
 0  1  0      0   3128   4132 430132   0   0     0  9920  174    81 0   4  96

Notice how there's planty of RAM. I'm writing sequentially to a file
on the ext2 filesystem. The disk I'm writing on is a 7200rpm IDE,
capable of ~ 22 MB/s and I'm still getting only ~ 9 MB/s. Weird!
-- 
Zlatko
