Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTFVNHd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbTFVNHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:07:33 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:33681 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S264689AbTFVNHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:07:31 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: GCC speed (was [PATCH] Isapnp warning)
Date: Sun, 22 Jun 2003 15:22:29 +0200
User-Agent: KMail/1.5.2
Cc: cw@f00f.org, torvalds@transmeta.com, geert@linux-m68k.org,
       alan@lxorguk.ukuu.org.uk, perex@suse.cz, linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com>
In-Reply-To: <20030621191705.3c1dbb16.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306221522.29653.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sunday 22 June 2003 04:17, you wrote:
> Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and produces a
> kernel which is 200k larger.
>
> It is simply worthless.

Recently, we did an unscientific but nonetheless informative tour through 
various optimization and compiler version questions here:

   http://marc.theaimsgroup.com/?t=105167074500002&r=3&w=2
   [RFC][PATCH] Faster generic_fls

As a result, my general impression is GCC 3.2 (and, I presume, GCC 3.3 as 
well) comes out better than 2.95.3 in terms of binary performance on x86.  I 
seem to recall there was one case in one algorithm variation on one procesor 
type where 2.95.3 won marginally, and otherwise GCC 3.2 took the trophy every 
time, sometimes by a significant margin.  I was able to get satisfactory 
performance in terms of size as well, by tweaking compile options.  (In 
general, just mindlessly setting O3 seems to work well.)

So I like GCC 3.2 in terms of code quality, at least for the limited set of 
things I've tested, but that's not the only consideration.  Current GCC is a 
whole lot better in terms of C99 compliance and produces better warnings.

As for compilation speed, yes, that sucks.  I doubt there's any rational 
reason for it, but I also agree with the idea that correctness and binary 
code performance should come first, then the compilation speed issue should 
be addressed.  I hope the gcc team does make it a priority at some point.  
For my own part, I'm putting together a cluster to address the compilation 
speed issue, i.e., I don't really care about it.  Even a dual PIII turns in 
satisfactory results in that regard, or a single K7.

Regards,

Daniel

