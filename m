Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966899AbWKUCVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966899AbWKUCVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 21:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966901AbWKUCVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 21:21:41 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1686 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S966899AbWKUCVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 21:21:40 -0500
Date: Mon, 20 Nov 2006 18:21:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jan Beulich <jbeulich@novell.com>,
       Metathronius Galabant <m.galabant@googlemail.com>,
       Michael Buesch <mb@bu3sch.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
Message-ID: <20061121022109.GF1397@sequoia.sous-sol.org>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org> <20061120234535.GD17736@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120234535.GD17736@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> Since I pushed an update to our Fedora users based on 2.6.18.2, a few people
> have reported they no longer have their RNG's detected.
> Here's one report: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=215144

Hmm, I wonder if the report is valid?  Jan's patch would have the correct
side effect of disabling false positives (for RNG identification).
Be good to check that it actually used to work.

Having said that, Jan the datasheet recommendation is looser than your
implementation.  It only recommends checking for manufacturer code,
you check device code as well.  Do you know of any scenarios where that
would matter (I can't conceive of any)?

thanks,
-chris
