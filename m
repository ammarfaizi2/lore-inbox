Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266815AbUGLNNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUGLNNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUGLNNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:13:42 -0400
Received: from gate.in-addr.de ([212.8.193.158]:44985 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S266815AbUGLNNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:13:39 -0400
Date: Mon, 12 Jul 2004 15:13:12 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712131312.GY3933@marowsky-bree.de>
References: <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com> <20040712115003.GV3933@marowsky-bree.de> <20040712120127.GB16604@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040712120127.GB16604@devserv.devel.redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-12T14:01:27,
   Arjan van de Ven <arjanv@redhat.com> said:

> I'm not convinced that's a good idea, in that it exposes what is
> basically VM internals to userspace, which then would become a
> set-in-stone interface....

But I'm also not a big fan of moving all HA relevant infrastructure into
the kernel. Membership and DLM are the first ones; then follows
messaging (and reliable and globally ordered messaging is somewhat
complex - but if one node is slow, it will hurt global communication
too, so...), next someone argues that a node always must be able to
report which resources it holds and fence other nodes even under memory
pressure, and there goes the cluster resource manager and fencing
subsystem into the kernel too etc...

Where's the border? 

And what can we do to make critical user-space infrastructure run
reliably and with deterministic-enough & low latency instead of moving
it all into the kernel?

Yes, the kernel solves these problems right now, but is that really the
path we want to head down? Maybe it is, I'm not sure, afterall we also
have the entire regular network stack in the kernel, but maybe also it
is not.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

