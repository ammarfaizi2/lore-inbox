Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUBLCXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 21:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUBLCXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 21:23:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63677
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261872AbUBLCXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 21:23:15 -0500
Date: Thu, 12 Feb 2004 03:23:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Olien <dmo@osdl.org>
Cc: Diego Calleja <grundig@teleline.es>, Michael Frank <mhf@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved writes
Message-ID: <20040212022314.GS4478@dualathlon.random>
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com> <200402120502.39300.mhf@linuxmail.org> <20040211221806.106eed62.grundig@teleline.es> <20040212020019.GA22344@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212020019.GA22344@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 06:00:19PM -0800, Dave Olien wrote:
> 
> 2.4 does not have deadline scheduler.  But the 2.6 deadline scheduler
> is more similar to 2.4's scheduler than is the anticipatory scheduler.

the main difference is that 2.4 isn't in function of time, it's in
function of requests, no matter how long it takes to write a request, so
it's potentially optimizing slow devices when you don't care about
latency (deadline can be tuned for each dev via
/sys/block/*/queue/iosched/).
