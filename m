Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFAA7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFAA7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVFAA6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:58:04 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:27034 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261192AbVFAA45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:56:57 -0400
Message-Id: <429D07E8.1030802@khandalf.com>
Date: Wed, 01 Jun 2005 02:57:12 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
    <1117556283.2569.26.camel@localhost.localdomain>
    <20050531171143.GS5413@g5.random>
    <1117561379.2569.57.camel@localhost.localdomain>
    <20050531175152.GT5413@g5.random>
    <1117564192.2569.83.camel@localhost.localdomain>
In-Reply-To: <1117564192.2569.83.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: b4ef541031b5fd831c7114bab66c0ccc
X-Transmit-Date: Wednesday, 1 Jun 2005 2:57:36 +0200
X-Message-Uid: 0000b49cec9d0ebc0000000200000000429d0800000b76fd00000001000b8f88
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 32701; Body=2
	Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My understanding is that the RT patch is (a) optional, and (b)
significantly reduces the latency to get to user mode RT applications,
in user mode, to the order of a few 10s of u-seconds, _almost_
guaranteed,

- this solves lots of problems, either free, or for very little
  (commercial) overhead cost, I will come to other costs below.

Thus, unless anyone argues the code is wrong, damaging to stability
(after it is debugged in the normal way) or increases scheduling
overhead even when configured out, it is a Good Thing (TM).

Arguments about u-kernels, mono-kernels, APIs ... notwithstanding;
near HARD REAL TIME in a commodity OS is VERY VALUABLE.

Now lets turn to REALLY HARD REAL TIME and LIFE and MISSION critical
systems, Depending on your critical time, ie the maximum period from
input to reaction:

- it may not be possible, eg 1 fermato-second, today, you must do
  a system re-design, or maybe you can't build the system

- you may be forced to compute the response in dedicated hardware,
  measuring the gate-delay-sum to response

- you may be able to do it with one or more dedicated COTS cpus, ram ...
  by assembly coding the critical paths, and computing worst case
  timings

- or you may be able to use a RT commodity OS eg Linux, and process
  more than one thread on each processor

Each of these alternatives is progressively cheaper, in terms of
equipment and dedicated development time, and enables less skilled
developers to contribute to both initial development and on-going
maintenance.

Other considerations, eg no single point of failure, may well come into
play eg aircraft flight controls, particularly if the airframe is,
inherently, unstable.

So to summarize:

(a) Critical RT may need to be specially hardware engineered, always
(b) Good OS RT latency is a good thing and will significantly promote
    Linux

(c) I havnt heard any argument that the RT patch causes intolerable
    scheduler overhead, but neither has the increase been quantified.

I think it is very useful.


-- 
mit freundlichen Grüßen, Brian.

