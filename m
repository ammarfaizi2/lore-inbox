Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756966AbWKVHvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbWKVHvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbWKVHvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:51:19 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:18322 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1756966AbWKVHvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:51:18 -0500
Message-Id: <45640FF4.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 22 Nov 2006 08:53:08 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chris Wright" <chrisw@sous-sol.org>
Cc: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Michael Buesch" <mb@bu3sch.de>,
       "Metathronius Galabant" <m.galabant@googlemail.com>,
       <stable@kernel.org>, "Michael Krufky" <mkrufky@linuxtv.org>,
       "Justin Forbes" <jmforbes@linuxtx.org>, <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, <akpm@osdl.org>,
       <torvalds@osdl.org>, "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Dave Jones" <davej@redhat.com>, "Greg Kroah-Hartman" <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
References: <20061101053340.305569000@sous-sol.org>
 <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com>
 <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com>
 <20061122015046.GI1397@sequoia.sous-sol.org>
In-Reply-To: <20061122015046.GI1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It does appear to work w/out the patch.  I've asked for a small bit
>of diagnostics (below), perhaps you've got something you'd rather see?
>I expect this to be a 24C0 LPC Bridge.

Yes, that's what I'd have asked for. If it works, I expect the device
code to be different, or both manufacturer and device code to be
invalid. Depending on the outcome, perhaps we'll need an override
option so that this test can be partially (i.e. just the device code
part) or entirely (all the FWH detection) skipped.
The base problem is the vague documentation of the whole
detection mechanism - a lot of this I had to read between the lines.

Jan

