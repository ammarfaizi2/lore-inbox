Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUL0ACO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUL0ACO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUL0ACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:02:14 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:24196 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261386AbUL0ACK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:02:10 -0500
Date: Sun, 26 Dec 2004 16:01:12 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Florian Weimer <fw@deneb.enyo.de>, 7eggert@gmx.de,
       Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free maps
Message-ID: <20041227000112.GB29854@taniwha.stupidest.org>
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <fa.n04s9ar.17sg3f@ifi.uio.no> <E1ChwhG-00011c-00@be1.7eggert.dyndns.org> <87wtv464ty.fsf@deneb.enyo.de> <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 03:12:45PM -0800, Linus Torvalds wrote:

> Anyway, at this point I think the most interesting question is
> whether it actually improves any macro-benchmark behaviour, rather
> than just a page fault latency tester microbenchmark..

i can't see how is many cases it won't make things *worse* in many
cases, especially if you use hardware

it seems you will be evicting (potentially) useful cache-lines from
the CPU when using hardware scrubbing in many cases and when using the
CPU if the tuning isn't right just trashing the caches anyhow

I'd really like to see how it affects something like make -j<n> sorta
things (since gcc performance is something i personally care about
more than how well some contrived benchmark does)
