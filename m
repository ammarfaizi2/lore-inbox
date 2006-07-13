Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWGMJWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGMJWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWGMJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:21:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964865AbWGMJV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:21:59 -0400
Date: Thu, 13 Jul 2006 02:18:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: andrea@cpushare.com
Cc: bruce@andrew.cmu.edu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       bunk@stusta.de, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       alan@redhat.com, torvalds@osdl.org, mingo@elte.hu
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-Id: <20060713021818.b0c0093e.akpm@osdl.org>
In-Reply-To: <20060713083441.GD28310@opteron.random>
References: <20060630145825.GA10667@opteron.random>
	<20060711073625.GA4722@elte.hu>
	<20060711141709.GE7192@opteron.random>
	<1152628374.3128.66.camel@laptopd505.fenrus.org>
	<20060711153117.GJ7192@opteron.random>
	<1152635055.18028.32.camel@localhost.localdomain>
	<p73wtain80h.fsf@verdi.suse.de>
	<20060712210732.GA10182@elte.hu>
	<20060712185103.f41b51d2.akpm@osdl.org>
	<44B5F9E6.8070501@andrew.cmu.edu>
	<20060713083441.GD28310@opteron.random>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 10:34:41 +0200
andrea@cpushare.com wrote:

> Both patches are obsoleted by the new logic in the context switch that
> uses the bitflags to enter the slow path, see Chuck's patch.

What darn patch?

<looks>

hm, p73wtain80h.fsf@verdi.suse.de, who appears to be Andi has (again)
removed me from cc.  Possibly an act of mercy ;)

> As long as seccomp won't be nuked from the kernel, Chuck's patch seems
> the way to go.

I see "[compile tested only; requires just-sent fix to i386 system.h]", so
an appropriate next step would be for you to review, test, sign-off and
forward it, please.

> But the point is that I've no idea anymore what will happen to
> seccomp so perhaps all patches will be useless.

Shrug.  If we can optimise the current code, fine.  If there's a default-on
config option that makes no-TSC seccomp have zero overhead, better.  If that
makes us go back to doing useful stuff, perfect.
