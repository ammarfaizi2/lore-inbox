Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318932AbSHEXmW>; Mon, 5 Aug 2002 19:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSHEXmV>; Mon, 5 Aug 2002 19:42:21 -0400
Received: from pat.uio.no ([129.240.130.16]:18054 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318932AbSHEXmV>;
	Mon, 5 Aug 2002 19:42:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15695.3634.832970.240016@charged.uio.no>
Date: Tue, 6 Aug 2002 01:45:54 +0200
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fragment flooding in 2.4.x/2.5.x
In-Reply-To: <200208052330.DAA22912@sex.inr.ac.ru>
References: <15694.33047.965504.346909@charged.uio.no>
	<200208052330.DAA22912@sex.inr.ac.ru>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

     > Hello!
    >> the bug has already been known to crash a few servers...

     > Sorry? What crash do you speak about?

You'll find it documented on RedHat's Bugzilla (can't remember the
exact reference - sorry). Basically the first RH-7.3 kernels were
causing a DOS on a couple of Netapps w/ Gigabit connections.

The DOS was traced to a combination of Linux flooding the server with
all these fragments w/o headers (our bug), coupled with inadequate
garbage collection of said fragments on the Netapp side (their bug).

Cheers,
  Trond
