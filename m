Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWG1Nqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWG1Nqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWG1Nqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:46:51 -0400
Received: from ns.suse.de ([195.135.220.2]:53983 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161144AbWG1Nqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:46:50 -0400
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building the kernel on an SMP box?
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Jul 2006 15:46:45 +0200
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
Message-ID: <p73wt9x4zay.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian D. McGrew" <brian@visionpro.com> writes:
> 
> So, to ask the group that should know the best ... What would be a
> reasonable configuration to get my builds down under five minutes or so?
> And then to go to the extreme, what kind of horsepower should I be
> looking for if I want get the build times down to say a minute or so???

Depending on your build pattern you can likely speed up rebuilds by
using ccache. 

If that doesn't help get one or two (or more as needed) cheap dual
core systems and use icecream (http://en.opensuse.org/Icecream) to do
a cluster build and build with -jN (N=2*available cores/threads or so)

To combine icecream and ccache in the same build you can use 
ftp://ftp.firstfloor.org/pub/ak/smallsrc/icecache.c

For parallel builds modular builds are faster than static builds
because otherwise the linker becomes a bottleneck.

-Andi
