Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUFEW7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUFEW7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUFEW7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:59:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262370AbUFEW7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:59:36 -0400
Date: Sat, 5 Jun 2004 15:57:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Robert Love <rml@ximian.com>
Cc: cw@f00f.org, arjanv@redhat.com, torvalds@osdl.org,
       russ@elegant-software.com, linux-kernel@vger.kernel.org
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-Id: <20040605155709.10fd917d.davem@redhat.com>
In-Reply-To: <1086475663.7940.50.camel@localhost>
References: <40C1E6A9.3010307@elegant-software.com>
	<Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	<20040605205547.GD20716@devserv.devel.redhat.com>
	<20040605215346.GB29525@taniwha.stupidest.org>
	<1086475663.7940.50.camel@localhost>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 18:47:43 -0400
Robert Love <rml@ximian.com> wrote:

> It is almost certainly done to improve the speed of some stupid
> microbenchmark - say, one that just calls getpid() repeatedly (simple
> because it is NOT slow) to measure system call overhead.

Luckily lmbench and friends use getppid() specifically because it
is impossible to cache that (as far as I can tell).
