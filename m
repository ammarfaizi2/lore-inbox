Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWGNGds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWGNGds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWGNGds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:33:48 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:14306
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1030222AbWGNGdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:33:47 -0400
Date: Fri, 14 Jul 2006 08:33:46 +0200
From: andrea@cpushare.com
To: Andrew Morton <akpm@osdl.org>
Cc: bruce@andrew.cmu.edu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       bunk@stusta.de, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       alan@redhat.com, torvalds@osdl.org, mingo@elte.hu
Subject: Re: [PATCH] TIF_NOTSC and SECCOMP prctl
Message-ID: <20060714063346.GG18774@opteron.random>
References: <20060711153117.GJ7192@opteron.random> <1152635055.18028.32.camel@localhost.localdomain> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <20060712185103.f41b51d2.akpm@osdl.org> <44B5F9E6.8070501@andrew.cmu.edu> <20060713083441.GD28310@opteron.random> <20060713021818.b0c0093e.akpm@osdl.org> <20060714060932.GE18774@opteron.random> <20060713232727.ead103f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713232727.ead103f8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 11:27:27PM -0700, Andrew Morton wrote:
> Using a bit <= 15 will cause kernel to take the work_notifysig path
> "pending work-to-be-done flags are in LSW".  I'm not sure what happens if
> there's such a flag set but nothing is set up to handle it.  I guess it
> stays set and processes never get out of the kernel again.

Ah ok, thanks.

> Perhaps TIF_SECCOMP should be >= 16 too - the special-case in
> _TIF_ALLWORK_MASK looks odd.

It's checked with testw so it must be < 16.
