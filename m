Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbTBZKLS>; Wed, 26 Feb 2003 05:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268703AbTBZKLS>; Wed, 26 Feb 2003 05:11:18 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:18112 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268702AbTBZKLS>; Wed, 26 Feb 2003 05:11:18 -0500
Date: Wed, 26 Feb 2003 10:19:05 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: schlicht@uni-mannheim.de, torvalds@transmeta.com, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-ID: <20030226111905.GA32415@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, schlicht@uni-mannheim.de,
	torvalds@transmeta.com, hugh@veritas.com,
	linux-kernel@vger.kernel.org
References: <200302251908.55097.schlicht@uni-mannheim.de> <20030226103742.GA29250@suse.de> <20030226015409.78e8e1fb.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226015409.78e8e1fb.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 01:54:09AM -0800, Andrew Morton wrote:

 > > Just one comment. You moved quite a few of the preempt_disable/enable
 > > pairs outside of the CONFIG_SMP checks.  The issue we're working against
 > > here is to try and prevent preemption and ending up on a different CPU.
 > > As this cannot happen if CONFIG_SMP=n, I don't see why you've done this.
 > Just in two places.

Ok, slight exaggeration 8-)  Looks good to me.

btw, (unrelated) shouldn't smp_call_function be doing magick checks
with cpu_online() ?

		Dave

