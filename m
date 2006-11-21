Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966954AbWKUJbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966954AbWKUJbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966957AbWKUJbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:31:25 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:56476 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S966954AbWKUJbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:31:24 -0500
Message-Id: <4562D5DA.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 21 Nov 2006 10:32:58 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Dave Jones" <davej@redhat.com>, "Chris Wright" <chrisw@sous-sol.org>
Cc: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Michael Buesch" <mb@bu3sch.de>,
       "Metathronius Galabant" <m.galabant@googlemail.com>,
       <stable@kernel.org>, "Michael Krufky" <mkrufky@linuxtv.org>,
       "Justin Forbes" <jmforbes@linuxtx.org>, <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, <akpm@osdl.org>,
       <torvalds@osdl.org>, "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Greg Kroah-Hartman" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
References: <20061101053340.305569000@sous-sol.org>
 <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com>
 <20061121022109.GF1397@sequoia.sous-sol.org>
In-Reply-To: <20061121022109.GF1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Chris Wright <chrisw@sous-sol.org> 21.11.06 03:21 >>>
>* Dave Jones (davej@redhat.com) wrote:
>> Since I pushed an update to our Fedora users based on 2.6.18.2, a few people
>> have reported they no longer have their RNG's detected.
>> Here's one report: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=215144 
>
>Hmm, I wonder if the report is valid?  Jan's patch would have the correct
>side effect of disabling false positives (for RNG identification).
>Be good to check that it actually used to work.

Indeed, that is quite significant to know here.

>Having said that, Jan the datasheet recommendation is looser than your
>implementation.  It only recommends checking for manufacturer code,
>you check device code as well.  Do you know of any scenarios where that
>would matter (I can't conceive of any)?

Since Intel doesn't list any other device codes, I suppose there are none.
But of course, it's not entirely impossible that there are others, but I
wouldn't want to relax the already weak check; I'd rather want to add
other device codes if we have proof that these are valid.

Jan
