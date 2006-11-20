Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWKTXsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWKTXsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbWKTXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:48:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40676 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030538AbWKTXsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:48:11 -0500
Date: Mon, 20 Nov 2006 18:45:35 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jan Beulich <jbeulich@novell.com>,
       Metathronius Galabant <m.galabant@googlemail.com>,
       Michael Buesch <mb@bu3sch.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 46/61] fix Intel RNG detection
Message-ID: <20061120234535.GD17736@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	Jan Beulich <jbeulich@novell.com>,
	Metathronius Galabant <m.galabant@googlemail.com>,
	Michael Buesch <mb@bu3sch.de>, Greg Kroah-Hartman <gregkh@suse.de>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101054343.623157000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:34:26PM -0800, Chris Wright wrote:
 
 > From: Jan Beulich <jbeulich@novell.com>
 > 
 > [PATCH] fix Intel RNG detection
 > 
 > Previously, since determination whether there was an Intel random number
 > generator was based on a single bit, on systems with a matching bridge
 > device but without a firmware hub, there was a 50% chance that the code
 > would incorrectly decide that the system had an RNG.  This patch adds
 > detection of the firmware hub to better qualify the existence of an RNG.
 > 
 > There is one issue with the patch: I was unable to determine the LPC
 > equivalent for the PCI bridge 8086:2430 (since the old code didn't care
 > about which of the many devices provided by the ICH/ESB it was chose to use
 > the PCI bridge device, but the FWH settings live in the LPC device, so the
 > device list needed to be changed).
 > 
 > Signed-off-by: Jan Beulich <jbeulich@novell.com>
 > Signed-off-by: Michael Buesch <mb@bu3sch.de>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
 > Signed-off-by: Chris Wright <chrisw@sous-sol.org>


Since I pushed an update to our Fedora users based on 2.6.18.2, a few people
have reported they no longer have their RNG's detected.
Here's one report: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=215144

		Dave

-- 
http://www.codemonkey.org.uk
