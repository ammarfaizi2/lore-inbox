Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTJ1W3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJ1W3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:29:18 -0500
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:15757 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261796AbTJ1W3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:29:16 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16286.60534.924753.349385@wombat.chubb.wattle.id.au>
Date: Wed, 29 Oct 2003 09:23:50 +1100
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Machek <pavel@suse.cz>, felipe_alfaro@linuxmail.org, mochel@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-*
In-Reply-To: <20031028224101.3220e0a6.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
	<1067329994.861.3.camel@teapot.felipe-alfaro.com>
	<20031028093233.GA1253@elf.ucw.cz>
	<20031028224101.3220e0a6.sfr@canb.auug.org.au>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stephen" == Stephen Rothwell <sfr@canb.auug.org.au> writes:

Stephen> On Tue, 28 Oct 2003 10:32:33 +0100 Pavel Machek
Stephen> <pavel@suse.cz> wrote:
Stephen> We could invent a new signal whose default action is ignore
Stephen> ... Solaris has SIGFREEZE and SIGTHAW (the comment in the
Stephen> header file says used by CPR - whatever that is).  SIGSUSPEND
Stephen> and SIGRESUME?

CPR -- checkpoint/restart

POSIX said to use SIGCKPT and SIGCONT (in at least *one* of the draft
1003.1m standards -- I've lost access to them recently, and the
working group stopped working back in 2000)

Suspend/resume is essentially a system-wide checkpoint+restart.

Maybe use SIGCKPT and SIGCONT?  Or even SIGSTOP and SIGCONT (after
all, you're stopping the process, then restarting it)

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
