Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTI3Nxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTI3Nxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:53:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50267 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261473AbTI3Nxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:53:47 -0400
Date: Tue, 30 Sep 2003 14:53:24 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930135324.GC5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	richard.brunner@amd.com
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com> <20030930133936.GA28876@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930133936.GA28876@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:39:36PM +0100, Jamie Lokier wrote:
 > Dave Jones wrote:
 > > This looks to be completely gratuitous. Why disable it when we have the
 > > ability to work around it ?
 > 
 > Because some people expressed a wish to have kernels that don't
 > contain the workaround code, be they P4-optimised or 486-optimised
 > kernels.

And those people are wrong. If they want to save bloat, instead of
'fixing' things by removing <1 page of .text, how about working on
some of the real problems like shrinking some of the growth of various
data structures that actually *matter*.

The "I don't want Athlon code in my kernel because I run a P4 and
it makes it slow/bigger" argument is totally bogus. It's akin to
the gentoo-esque "I compiled my distro with -march=p4 and now
my /bin/ls is faster than yours" argument.

 > After all we have kernels that don't contain the F00F
 > workaround too.  I'm not pushing this patch as is, it's for
 > considering the pros and cons.

F00F workaround was enabled on every kernel that is possible
to boot on affected hardware last time I looked.
This is what you seem to be missing, it's not optional.
If its possible to boot that kernel on affected hardware, 
it needs errata workarounds.

 > CONFIG_X86_PREFETCH_WORKAROUND makes more makes more sense with the
 > recently available "split every x86 CPU into individually selectable
 > options" patch, and, on reflection, that's probably where it belongs.

Said patch isn't included in mainline, so this argument is bogus.
Relative merits of that patch were already discussed in another thread.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
