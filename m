Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUJDP51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUJDP51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUJDP50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:57:26 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62904 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268246AbUJDPz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:55:59 -0400
Date: Mon, 4 Oct 2004 08:53:27 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041004085327.727191bf.pj@sgi.com>
In-Reply-To: <843670000.1096902220@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin writes:
> OK, then your "exclusive" cpusets aren't really exclusive at all, since
> they have other stuff running in them.

What's clear is that 'exclusive' is not a sufficient precondition for
whatever it is that CKRM needs to have sufficient control.

Instead of trying to wrestle 'exclusive' into doing what you want, do me
a favor, if you would.  Help me figure out what conditions CKRM _does_
need to operate within a cpuset, and we'll invent a new property that
satisfies those conditions.

See my earlier posts in the last hour for my efforts to figure out what
these conditions might be.  I conjecture that it's something along the
lines of:

    Assuring each CKRM instance that it has control of some
    subset of a system that's separate and non-overlapping,
    with all Memory, CPU, Tasks, and Allowed masks of said
    Tasks either wholly owned by that CKRM instance, or
    entirely outside.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
