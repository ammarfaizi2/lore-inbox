Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRHSK4g>; Sun, 19 Aug 2001 06:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270333AbRHSK40>; Sun, 19 Aug 2001 06:56:26 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:55812 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S270331AbRHSK4N>; Sun, 19 Aug 2001 06:56:13 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108191056.f7JAuLH09380@wildsau.idv-edu.uni-linz.ac.at>
Subject: please remove min/max from kernel.h
To: linux-kernel@vger.kernel.org
Date: Sun, 19 Aug 2001 12:56:21 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I found that those 3-argumented macros min/max in linux/kernel.h wont
only break my modules, but others as well, e.g. I tried to compile
2.4.9 with IPSec (Freeswan). It gives me:

  : make[1]: Leaving directory `/data/root/linux-2.4.9'
  : utils/errcheck out.kbuild
  : 
  : ***ERRORS DETECTED in out.kbuild (examine file for details):
  : radij.c:274: parse error before `__x'
  : make[4]: *** [radij.o] Error 1

"__x". does that ring a bell? let's please have min/max macros with
two arguments only as god wanted them to have and get rid of the
three-eyed zyclops, who only exists in greek mythology. for my part,
I will #undef min, #undef max anyway.

