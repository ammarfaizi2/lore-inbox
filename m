Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUI1QSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUI1QSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUI1QSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:18:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:5568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267961AbUI1QSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:18:05 -0400
Date: Tue, 28 Sep 2004 12:08:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: rml@novell.com, ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040928120830.7c5c10be.akpm@osdl.org>
In-Reply-To: <1096350328.26742.52.camel@orca.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee <ray-lk@madrabbit.org> wrote:
>
> The current way pads out the structure unnecessarily, and still doesn't
> handle the really long filenames, by your admission. It incurs extra
> syscalls, as few filenames are really 256 characters in length. 

Why don't you pass a file descriptor into the syscall instead of a pathname?
You can then take a ref on the inode and userspace can close the file.
That gets you permission checking for free.
