Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVD2ULC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVD2ULC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVD2UJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:09:27 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20907 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262930AbVD2UEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:04:22 -0400
Subject: Re: which ioctls matter across filesystems
From: Robert Love <rml@novell.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1114804426.12692.49.camel@lade.trondhjem.org>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:03:53 -0400
Message-Id: <1114805033.6682.150.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 15:53 -0400, Trond Myklebust wrote:

> We are discussing the equivalent of dnotify as a potential candidate for
> the first minor version of NFSv4, but not inotify.
> The purpose of our dnotify implementation is address the needs of things
> like file browsers that don't really care about synchronous notification
> of changes, but that do currently cause a lot of unnecessary traffic on
> the wire due to constantly polling stat() and doing readdir() updates.
> The jury is still out as to whether or not the callbacks actually do
> reduce on-the-wire traffic, though, so we may drop it.

What about inotify makes it insufficient for your needs?

> What kind of real-world applications exist out there that need inotify
> functionality, and what sort of requirements do they have (in particular
> w.r.t. the notification mechanism)?

A few worksets:

	- Current users, such as FAM and Samba, that need simple file
	  change notification
	- Random applications that want to watch a file or two
	- The Linux desktop
	- Real-time live-updating indexing systems, such as Beagle,
	  that compete with f.e. Apple's Spotlight.

Best,

	Robert Love


