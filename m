Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUI1Qyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUI1Qyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUI1Qyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:54:41 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3246 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267993AbUI1Qyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:54:39 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andrew Morton <akpm@osdl.org>, Ray Lee <ray-lk@madrabbit.org>,
       ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
In-Reply-To: <41599456.6040102@nortelnetworks.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 12:53:18 -0400
Message-Id: <1096390398.4911.30.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 10:41 -0600, Chris Friesen wrote:
> Andrew Morton wrote:
> 
> > Why don't you pass a file descriptor into the syscall instead of a pathname?
> > You can then take a ref on the inode and userspace can close the file.
> > That gets you permission checking for free.
> 
> For passing in the data, that would work.  Wouldn't you still need a name or 
> path when getting data back though?

Does Andrew mean an fd on the thing being watched?

That is what we are trying to fix with dnotify: the open fd's are pin
the device and prevent unmount, making notification on removable devices
impossible.  Such a 1:1 relationship also opens way too many fd's.

	Robert Love


