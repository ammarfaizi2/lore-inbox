Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUI1VXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUI1VXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUI1VW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:22:26 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:35833 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S268037AbUI1VVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:21:16 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096405848.5177.15.camel@issola.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <1096403167.30123.5.camel@vertex>
	 <1096405848.5177.15.camel@issola.madrabbit.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096406467.30123.42.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 17:21:07 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.28.2
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 17:10, Ray Lee wrote:
> On Tue, 2004-09-28 at 16:26 -0400, John McCutchan wrote:
> > On Tue, 2004-09-28 at 01:45, Ray Lee wrote:
> > > The current way pads out the structure unnecessarily, and still doesn't
> > > handle the really long filenames, by your admission. It incurs extra
> > > syscalls, as few filenames are really 256 characters in length. It makes
> > > userspace double-check whether the filename extends all the way to the
> > > boundary of the structure, and if so, then go back to the disk to try to
> > > guess what the kernel really meant to say.
> > 
> > I thought that filenames where limited to 256 characters? That was the
> > idea behind the 256 character limit.
> 
> I thought so too, as linux/limits.h claims:
> 
> #define NAME_MAX         255    /* # chars in a file name */
> 
> But Robert earlier said:
> 
> > Technically speaking, a single filename can be as large as PATH_MAX-1.
> > The comment is just a warning, though, to explain the dreary
> > theoretical side of the world.
> 
> ...where PATH_MAX is 4096.
> 
> So, got me. I believe there is some minor confusion going on.

A quick test of 'echo "" > XXXX...XXX' the filename seems to be limited
to 256.

John
