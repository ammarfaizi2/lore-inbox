Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTJLUOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTJLUOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:14:49 -0400
Received: from gprs149-193.eurotel.cz ([160.218.149.193]:19841 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263523AbTJLUOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:14:47 -0400
Date: Sun, 12 Oct 2003 22:14:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       Mark Mielke <mark@mark.mielke.cc>, G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031012201419.GA664@elf.ucw.cz>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010144837.GB12134@mark.mielke.cc> <20031010150122.GD727@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010150122.GD727@holomorphy.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Perhaps I've naive here, but - with hot-pluggable CPU machines, do you not
> > de-activate the CPU through software first, before pulling the CPU out, at
> > which point it is not in use?
> 
> Well, you deleted my reply, but never mind that.
> 
> This obviously can't work unless the kernel gets some kind of warning.
       ~~~~~~~~~~~~~~~~~~~~
> Userspace and kernel register state, once lost that way, can't be
> recovered, and if tasks are automatically suspended (e.g. cpu dumps to
> somewhere and a miracle occurs), you'll deadlock if the kernel was in
> a non-preemptible critical section at the time.

Of course it _can_ work without warning, it would just be *extremely*
hard to do within linux. [When you have big enough cluster, you have
to deal with nodes failing randomly; when you get big enough SMP,
you'll have same issue].

One [stupid] method to handle this would be to do periodic system
snapshots, and if cpu fails rollback and try again without that
cpu. You'll get nasty issues with network (duplicated packets on tx),
and funny stuff on console, but certainly way to make this work
exists.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
