Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWGMIdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWGMIdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWGMIdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:33:46 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:63109
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932483AbWGMIdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:33:46 -0400
Date: Thu, 13 Jul 2006 10:34:41 +0200
From: andrea@cpushare.com
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, bunk@stusta.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713083441.GD28310@opteron.random>
References: <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random> <1152635055.18028.32.camel@localhost.localdomain> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <20060712185103.f41b51d2.akpm@osdl.org> <44B5F9E6.8070501@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B5F9E6.8070501@andrew.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 03:44:38AM -0400, James Bruce wrote:
> Andrea,
> what happened to Andrew James Wade's rewording [1] of your config help? 
>   It seemed to disappear from what was submitted to akpm.

Andrew picked the patch I made originally, before Andrew James Wade
patched it.

Both patches are obsoleted by the new logic in the context switch that
uses the bitflags to enter the slow path, see Chuck's patch. That will
prevent the need of a config option because it's zero cost like the
core of seccomp.

As long as seccomp won't be nuked from the kernel, Chuck's patch seems
the way to go.

But the point is that I've no idea anymore what will happen to
seccomp so perhaps all patches will be useless.
