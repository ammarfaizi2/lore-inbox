Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUI1Vio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUI1Vio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUI1Vio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:38:44 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20913 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268039AbUI1VgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:36:24 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Ray Lee <ray-lk@madrabbit.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096406467.30123.42.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <1096403167.30123.5.camel@vertex>
	 <1096405848.5177.15.camel@issola.madrabbit.org>
	 <1096406467.30123.42.camel@vertex>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 17:35:01 -0400
Message-Id: <1096407301.4911.79.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 17:21 -0400, John McCutchan wrote:

> A quick test of 'echo "" > XXXX...XXX' the filename seems to be limited
> to 256.

I think ext3 limits filenames to 255 or 256 characters.  Other
filesystems probably have other limits.

The POSIX absolute maximum is PATH_MAX for the entire path, which means
that a legal filename could theoretically be PATH_MAX-1 (a file in the
root directory).  But maybe in practice this is never an issue.

We still have the issue where 256 is much larger than the average file.

But, as I have said before, I am _for_ keeping the thing static,
although I acknowledge all the points about going dynamic.

	Robert Love


