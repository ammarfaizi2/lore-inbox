Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266653AbUBQXtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUBQXtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:49:18 -0500
Received: from dp.samba.org ([66.70.73.150]:65208 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266573AbUBQXtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:49:13 -0500
Date: Wed, 18 Feb 2004 10:48:49 +1100
From: Anton Blanchard <anton@samba.org>
To: davidm@hpl.hp.com
Cc: torvalds@osdl.org, Michel D?nzer <michel@daenzer.net>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
Message-ID: <20040217234848.GB22534@krispykreme>
References: <16434.35199.597235.894615@napali.hpl.hp.com> <1077054385.2714.72.camel@thor.asgaard.local> <16434.36137.623311.751484@napali.hpl.hp.com> <1077055209.2712.80.camel@thor.asgaard.local> <16434.37025.840577.826949@napali.hpl.hp.com> <1077058106.2713.88.camel@thor.asgaard.local> <16434.41884.249541.156083@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16434.41884.249541.156083@napali.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here is a proposed patch for fixing the compile-warning that shows up
> when compiling radeon_state.c on a 64-bit platform (Itanium, in my
> case).  According to Michel, RADEON_PARAM_SAREA_HANDLE is used only on
> embedded platforms and since it is not possible to fix the problem
> without breaking backwards-compatibility for those platforms, the
> interim fix is to simply desupport this particular ioctl() on 64-bit
> platforms (i.e., make it fail with EINVAL).
> 
> If there are no objections, please apply.

A small thing, could the comment be constrained to 80 columns? :)

Anton
