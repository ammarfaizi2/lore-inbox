Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262544AbSJBSkh>; Wed, 2 Oct 2002 14:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbSJBSkh>; Wed, 2 Oct 2002 14:40:37 -0400
Received: from inje.iskon.hr ([213.191.128.16]:48614 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S262544AbSJBSkf>;
	Wed, 2 Oct 2002 14:40:35 -0400
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>
	<3D99A2F2.70102@oracle.com> <dnelbaclvo.fsf@magla.zg.iskon.hr>
	<3D99B672.2090805@oracle.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Wed, 02 Oct 2002 20:45:54 +0200
In-Reply-To: <3D99B672.2090805@oracle.com> (Alessandro Suardi's message of
 "Tue, 01 Oct 2002 16:51:30 +0200")
Message-ID: <874rc4fzml.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> The more complicated bug you're talking about is the exec_mmap
>   change introduced in 2.5.19 and fixed a handful of versions
>   later, possibly .28, where PMON wouldn't start after 120"...
>   I guess :)

Oh, well, if that one is really fixed, then I have another one. ;)

After some time up, few select & few inserts, Oracle decided to die
(2.5.40 + Hugh's patch, SMP, Oracle 9.0.1.4 - works flawlessly on
2.4.19). I have a full coredump, but I don't know what to do with it
(if somebody wants it, just say). It seems benchmarking will
wait... :(


*** 2002-10-02 20:15:27.634
*** SESSION ID:(4.1) 2002-10-02 20:15:27.583
BH (0x0x60fee288) file#: 1 rdba: 0x004000c7 (1/199) class 1 ba: 0x0x60c9a000
  set: 3, dbwrid: 0
  hash: [53509d88,53509d88], lru: [60fee370,60fee220]
  LRU flags: 
  ckptq: [NULL] fileq: [NULL]
  st: XCURRENT, md: NULL, rsop: 0x(nil), tch: 1
  L:[0x0.0.0] H:[0x0.0.0] R:[0x0.0.0]
*** 2002-10-02 20:15:27.634
ksedmp: internal or fatal error
ORA-00600: Message 600 not found; No message file for product=RDBMS, facility=ORA; arguments: [kcbkllrba_2]

...

-- 
Zlatko
