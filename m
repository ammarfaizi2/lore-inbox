Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTEHQyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTEHQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:54:51 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:1999 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261868AbTEHQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:54:48 -0400
Date: Thu, 8 May 2003 17:36:47 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Torsten Landschoff <torsten@debian.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030508173647.W626@nightmaster.csn.tu-chemnitz.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507150429.GA7248@stargate.galaxy> <20030507160144.GS8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030507160144.GS8931@holomorphy.com>; from wli@holomorphy.com on Wed, May 07, 2003 at 09:01:44AM -0700
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Dorb-0004Os-00*X8gTAVipnm2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 09:01:44AM -0700, William Lee Irwin III wrote:
> Pure per-cpu stacks would require the interrupt model of programming to
> be used, which is a design decision deep enough it's debatable whether
> it's feasible to do conversions to or from at all, never mind desirable.
> Basically every entry point into the kernel is treated as an interrupt,
> and nothing can ever sleep or be scheduled in the kernel, but rather
> only register callbacks to be run when the event waited for occurs.
> Scheduling only happens as a decision of which userspace task to resume
> when returning from the kernel to userspace, though one could envision
> a priority queue discipline for processing the registered callbacks.

To illustrate that: It's basically a difference like between
fork() and spawn(). Threads (of control) are completely decoupled
und re-coupled only by the event/callback mechanism. 

This is introducing exactly the mechanisms Linus didn't like when
he decided, that he doesn't want a micro kernel architecture.

So it is not going to happen RSN.


Regards

Ingo Oeser
-- 
Marketing ist die Kunst, Leuten Sachen zu verkaufen, die sie
nicht brauchen, mit Geld, was sie nicht haben, um Leute zu
beeindrucken, die sie nicht moegen.
