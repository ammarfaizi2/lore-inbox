Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSHGCKD>; Tue, 6 Aug 2002 22:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSHGCKD>; Tue, 6 Aug 2002 22:10:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16656 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317081AbSHGCKC>; Tue, 6 Aug 2002 22:10:02 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.4.19 warnings cleanup
Date: 7 Aug 2002 02:07:42 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <aipvde$9da$1@gatekeeper.tmr.com>
References: <1028470583.14196.29.camel@irongate.swansea.linux.org.uk> <20020804.200246.26945647.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1028686062 9642 192.168.12.62 (7 Aug 2002 02:07:42 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020804.200246.26945647.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:

| A compiler isn't able to work out the control flow which
| makes sure ret is indeed initialized on every path to
| a use.  Solving such a problem is traveling salesman'ish :-)

This is true, but on the other hand I don't see much virtue in taking
the attitude that I'm sure the compiler is wrong to avoid the overhead
of initializing the variable or clarifying the code.

I totally agree that there are cases in which the compiler can't be sure
and the programmer is based on some outside assumptions of input values
or whatever, but I don't mind making the code robust in cases other than
innermost loops where I just can't fix it.

I'd rather set the initial value to NOTSET or NULL or some value which
will clearly show if you are setting what you think you are. I've
occasionally been surprised, particularly when trusting values passed
into a procedure.

Just my take on reliable vs. fast.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
