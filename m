Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSKTXSj>; Wed, 20 Nov 2002 18:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSKTXSj>; Wed, 20 Nov 2002 18:18:39 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:41866 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S263310AbSKTXSi>;
	Wed, 20 Nov 2002 18:18:38 -0500
Date: Wed, 20 Nov 2002 23:26:47 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
Message-ID: <20021120232647.GC11879@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net> <3DDB09C2.3070100@redhat.com> <20021120215540.GA11879@bjl1.asuk.net> <3DDC08AF.7020107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC08AF.7020107@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > I don't buy this argument.  You block signals, do something, unblock
> > signals.  There may be a _tiny_ delay in delivering the signal
> 
> Tiny?  You said yourself that fork can be expensive.

You can't receive a signal in a thread while it is forking anyway.

Erm, am I getting confused here?  I'm assuming that you can block
signals in _only_ the thread that is forking, leaving it unblocked in
the others.  I'm not very familiar with the current threaded signal
model - is the blocked-signal mask shared between all of them?

-- Jamie
