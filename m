Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291465AbSBHIVQ>; Fri, 8 Feb 2002 03:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291466AbSBHIVG>; Fri, 8 Feb 2002 03:21:06 -0500
Received: from nrg.org ([216.101.165.106]:33594 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S291465AbSBHIUy>;
	Fri, 8 Feb 2002 03:20:54 -0500
Date: Fri, 8 Feb 2002 00:20:37 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, Martin Wirth <Martin.Wirth@dlr.de>,
        <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C62D49A.4CBB6295@zip.com.au>
Message-ID: <Pine.LNX.4.40.0202080003360.613-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Andrew Morton wrote:
> I dunno.  The spin-a-bit-then-sleep lock has always struck me as
> i_dont_know_what_the_fuck_im_doing_lock().  Martin's approach puts
> the decision in the hands of the programmer, rather than saying
> "Oh gee I goofed" at runtime.

I completely agree, and I couldn't have put it better!  Kernel
programmers really should know exactly why, what, where and for how long
they are holding a lock.

This is why, incidently, I don't like any of the so-called lockless
schemes, including the original unix kernel monitor lock (i.e. only one
kernel thread active at a time), because they encourage unmaintainable
code where the critical sections are invisible to everyone and are
easily broken when someone accidently inserts a blocking function into
one of the invisible critical sections.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

