Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUFAVOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUFAVOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUFAVOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:14:15 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:63465 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265228AbUFAVOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:14:10 -0400
Subject: Re: why swap at all?
From: FabF <fabian.frederick@skynet.be>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406012022.i51KMFEB002660@turing-police.cc.vt.edu>
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
	 <1086114982.2278.5.camel@localhost.localdomain>
	 <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
	 <1086119611.2278.16.camel@localhost.localdomain>
	 <200406012000.i51K0vor019011@turing-police.cc.vt.edu>
	 <1086120865.2278.27.camel@localhost.localdomain>
	 <200406012022.i51KMFEB002660@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1086124536.2278.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Jun 2004 23:15:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 22:22, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 01 Jun 2004 22:14:26 +0200, FabF said:
> 
> > Boring....You can't have X root layer swapped to disk as it's often used
> > ! Some quick lsof | grep "libX" gives all frontal applications 'swapping
> > sensible' .fuser can do 'user resource reverse'.Kernel _can_ 'appl.
> > resource reverse' as well.
> 
> The point you're missing is that if you use a rule such as "everything using
> libX* isn't swappable", then the X *server* is suddenly the prime candidate for
> swapping out (as it's quite likely the biggest user of memory not using libX*).
> (Anybody who ever had the OOM killer whomp their X server to free up space
> fast when the *real* problem was a cluster of 6 or 8 "large but still smaller
> than the X server" processes knows exactly what I mean... ;)
> 
> > PS: I'm not talking about inactive desktop box.Such box has to be rl 3
> > and is not meant to be user (geek) relevant :)
> 
> So you're saying that I should have kicked my laptop down to runlevel 3 just
> because I went across the hall to the machine room to help get a few servers
> into racks?  Or every time I go into a meeting, or get stuck on a longish phone
> call?
> 
> Also, be *very* careful equating "user" with "geek" - at least some of us are
> trying to produce systems that suit the needs of non-geek users....
> 
	As I said, I think this thread is "becoming offtopic" but what can be
interesting is the swapping problem fragmentation :

	1.Global inactivity (what you're talking about)
	2.Application isolation (what we're talking about).

Geek or not, someone backgrounding an application doesn't want it to
down the box for X seconds some minutes later when it comes back and
such things arrive many times a day.Maybe you've got an idea about a
better rule(s) then ? (I mean for the 2 cases)

