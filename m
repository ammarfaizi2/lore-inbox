Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUI1VLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUI1VLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUI1VLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:11:13 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:30157 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S267935AbUI1VKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:10:49 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096403167.30123.5.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <1096403167.30123.5.camel@vertex>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Tue, 28 Sep 2004 14:10:48 -0700
Message-Id: <1096405848.5177.15.camel@issola.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:26 -0400, John McCutchan wrote:
> On Tue, 2004-09-28 at 01:45, Ray Lee wrote:
> > The current way pads out the structure unnecessarily, and still doesn't
> > handle the really long filenames, by your admission. It incurs extra
> > syscalls, as few filenames are really 256 characters in length. It makes
> > userspace double-check whether the filename extends all the way to the
> > boundary of the structure, and if so, then go back to the disk to try to
> > guess what the kernel really meant to say.
> 
> I thought that filenames where limited to 256 characters? That was the
> idea behind the 256 character limit.

I thought so too, as linux/limits.h claims:

#define NAME_MAX         255    /* # chars in a file name */

But Robert earlier said:

> Technically speaking, a single filename can be as large as PATH_MAX-1.
> The comment is just a warning, though, to explain the dreary
> theoretical side of the world.

...where PATH_MAX is 4096.

So, got me. I believe there is some minor confusion going on.

Ray

