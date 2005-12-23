Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbVLWTQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbVLWTQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 14:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbVLWTQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 14:16:49 -0500
Received: from fsmlabs.com ([168.103.115.128]:56770 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030606AbVLWTQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 14:16:48 -0500
X-ASG-Debug-ID: 1135365404-27256-16-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Fri, 23 Dec 2005 11:22:03 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: [PATCH RT 00/02] SLOB optimizations
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <43AB23C9.8010904@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0512231121450.1579@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org>
 <1135106124.13138.339.camel@localhost.localdomain>
 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
 <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu>
 <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu>
 <43A90C07.4000003@cosmosbay.com> <20051222211132.GA21742@elte.hu>
 <43AB23C9.8010904@cosmosbay.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810560-135381486-1135365723=:1579"
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6584
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810560-135381486-1135365723=:1579
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Dec 2005, Eric Dumazet wrote:

> Ingo Molnar a =E9crit :
> >=20
> > CLI/STI is extremely fast. (In fact in the -rt tree i'm using them with=
in
> > mutexes instead of preempt_enable()/preempt_disable(), because they are
> > faster and generate less register side-effect.)
> >=20
>=20
> Yes, but most of my machines have a ! CONFIG_PREEMPT kernel, so
> preempt_enable()/preempt_disable() are empty, thus faster than CLI/STI fo=
r
> sure :)
>=20
> Then, maybe the patch that moves 'current' in a dedicated x86_64 register=
 may
> help to lower  the cost of preempt_enable()/preempt_disable() on a
> CONFIG_PREEMPT kernel ?

I'm not sure if it'll make much of a difference over;

mov    %gs:offset,%reg

So 'current' already is fairly fast on x86_64.
---1463810560-135381486-1135365723=:1579--
