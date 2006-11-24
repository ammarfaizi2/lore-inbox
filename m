Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935046AbWKXUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935046AbWKXUcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935047AbWKXUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:32:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935046AbWKXUce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:32:34 -0500
Date: Fri, 24 Nov 2006 15:27:29 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Chris Wright <chrisw@sous-sol.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Michael Buesch <mb@bu3sch.de>,
       Metathronius Galabant <m.galabant@googlemail.com>, stable@kernel.org,
       Michael Krufky <mkrufky@linuxtv.org>,
       Justin Forbes <jmforbes@linuxtx.org>, alan@lxorguk.ukuu.org.uk,
       "Theodore Ts'o" <tytso@mit.edu>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       torvalds@osdl.org, Chuck Wolber <chuckw@quantumlinux.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
Message-ID: <20061124202729.GC29264@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Beulich <jbeulich@novell.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Michael Buesch <mb@bu3sch.de>,
	Metathronius Galabant <m.galabant@googlemail.com>,
	stable@kernel.org, Michael Krufky <mkrufky@linuxtv.org>,
	Justin Forbes <jmforbes@linuxtx.org>, alan@lxorguk.ukuu.org.uk,
	Theodore Ts'o <tytso@mit.edu>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
	torvalds@osdl.org, Chuck Wolber <chuckw@quantumlinux.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org> <20061120234535.GD17736@redhat.com> <20061121022109.GF1397@sequoia.sous-sol.org> <4562D5DA.76E4.0078.0@novell.com> <20061122015046.GI1397@sequoia.sous-sol.org> <45640FF4.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45640FF4.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 08:53:08AM +0100, Jan Beulich wrote:
 > >It does appear to work w/out the patch.  I've asked for a small bit
 > >of diagnostics (below), perhaps you've got something you'd rather see?
 > >I expect this to be a 24C0 LPC Bridge.
 > 
 > Yes, that's what I'd have asked for. If it works, I expect the device
 > code to be different, or both manufacturer and device code to be
 > invalid. Depending on the outcome, perhaps we'll need an override
 > option so that this test can be partially (i.e. just the device code
 > part) or entirely (all the FWH detection) skipped.
 > The base problem is the vague documentation of the whole
 > detection mechanism - a lot of this I had to read between the lines.

The bug report I referenced came back with this from that debug patch..

intel_rng: no version for "struct_module" found: kernel tainted.
intel_rng: pci vendor:device 8086:24c0 fwh_dec_en1 80 bios_cntl_val 2 mfc cb dvc 88
intel_rng: FWH not detected

		Dave

-- 
http://www.codemonkey.org.uk
