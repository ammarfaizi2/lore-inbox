Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUIZRVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUIZRVM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUIZRVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:21:12 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:49927 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S267793AbUIZRVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:21:10 -0400
Date: Sun, 26 Sep 2004 19:21:04 +0200
From: Olivier Galibert <galibert@pobox.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __initcall macros and C token pasting
Message-ID: <20040926172104.GA44528@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339104092510574c908525@mail.gmail.com> <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk> <9e473391040925121774e7e1e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391040925121774e7e1e1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 03:17:14PM -0400, Jon Smirl wrote:
> However this has a side effect. DRM drivers are distributed outside of
> the kernel. This leads to the possibility of wanting two drivers
> simultaneously loaded that need different versions of the core.
> Without the DRM macros we can only have one version of the core
> loaded. What are you going to do?

Stop distributing the drivers outside of the kernel?


> One response is to build a stable API for the core.

This has absolutely zero chance to happen, as the evolution of the
kernel has proven time and again.  The internal APIs of the kernel
aren't stable, however much we'd like them to be, because the best way
to do something at time t isn't the best way to do it at time t+1.
The best that is done is to try to change the drivers at the time the
core changes, and that only happens if the source of the drivers is
there along with the rest of the kernel.

  OG.
