Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSLITVe>; Mon, 9 Dec 2002 14:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSLITVe>; Mon, 9 Dec 2002 14:21:34 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:765 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S266120AbSLITVd>; Mon, 9 Dec 2002 14:21:33 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.61166.685927.298382@wombat.chubb.wattle.id.au>
Date: Tue, 10 Dec 2002 06:28:46 +1100
To: Rik van Riel <riel@conectiva.com.br>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Rusty Trivial Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>
Subject: Re: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed
 soft limits
In-Reply-To: <Pine.LNX.4.50L.0212091026410.21756-100000@imladris.surriel.com>
References: <15860.1070.521840.791396@wombat.chubb.wattle.id.au>
	<Pine.LNX.4.50L.0212091026410.21756-100000@imladris.surriel.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rik" == Rik van Riel <riel@conectiva.com.br> writes:

Rik> On Mon, 9 Dec 2002, Peter Chubb wrote: Wouldn't it be better to
Rik> simply take the soft limit down to min(new_rlim.rlim_cur,
Rik> new_rlim.rlim_max) ?
>> Single unix spec says to return EINVAL in this case.
>> 
>> [EINVAL] An invalid resource was specified; or in a setrlimit()
>> call, the new rlim_cur exceeds the new rlim_max.

Rik> So how about "the old rlim_cur exceeds the new rlim_max" ? ;)

You always have to set both, so the old value is irrelevant, except in
so far as rlim_max may not be increased except by a privileged
process.

setrlimit may return EINVAL if the actual usage is above the new
rlim_cur.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
