Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSLICjq>; Sun, 8 Dec 2002 21:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSLICjq>; Sun, 8 Dec 2002 21:39:46 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:65273 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262214AbSLICjp>; Sun, 8 Dec 2002 21:39:45 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.1070.521840.791396@wombat.chubb.wattle.id.au>
Date: Mon, 9 Dec 2002 13:47:10 +1100
To: Rik van Riel <riel@conectiva.com.br>
Cc: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>
Subject: Re: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed
 soft limits
In-Reply-To: <1054753245@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rik" == Rik van Riel <riel@conectiva.com.br> writes:

Rik> On Fri, 6 Dec 2002, Rusty Trivial Russell wrote:
>> > Just try "ulimit -H -m 10000" for memory limits that were not >
>> previously set.  You end up with (hard limit = 10000) < (soft limit
>> = > unlimited).

>> + if (new_rlim.rlim_cur > new_rlim.rlim_max) + return -EINVAL;

Rik> Wouldn't it be better to simply take the soft limit down to
Rik> min(new_rlim.rlim_cur, new_rlim.rlim_max) ?
 
Single unix spec says to return EINVAL in this case.

[EINVAL]
An invalid resource was specified; or in a setrlimit() call, the new
rlim_cur exceeds the new rlim_max.

 
