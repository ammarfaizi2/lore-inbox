Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUFEWrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUFEWrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUFEWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:47:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29377 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262329AbUFEWro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:47:44 -0400
Subject: Re: clone() <-> getpid() bug in 2.6?
From: Robert Love <rml@ximian.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040605215346.GB29525@taniwha.stupidest.org>
References: <40C1E6A9.3010307@elegant-software.com>
	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	 <20040605205547.GD20716@devserv.devel.redhat.com>
	 <20040605215346.GB29525@taniwha.stupidest.org>
Content-Type: text/plain
Date: Sat, 05 Jun 2004 18:47:43 -0400
Message-Id: <1086475663.7940.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 14:53 -0700, Chris Wedgwood wrote:

> glibc caches getpid() ?!?
> 
> it's not like it's a slow syscall or used often

It is almost certainly done to improve the speed of some stupid
microbenchmark - say, one that just calls getpid() repeatedly (simple
because it is NOT slow) to measure system call overhead.

Or maybe libc uses the PID a lot internally.  I don't know.

But it sure seems wrong.

	Robert Love


