Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbVLGS2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbVLGS2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbVLGS2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:28:03 -0500
Received: from peabody.ximian.com ([130.57.169.10]:5774 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751711AbVLGS2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:28:01 -0500
Subject: Re: [patch] add two inotify_add_watch flags
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1133927688.20396.8.camel@localhost.localdomain>
References: <1133927688.20396.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 13:26:02 -0500
Message-Id: <1133979962.6291.125.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 22:54 -0500, John McCutchan wrote:

> The below patch lets user space have more control over the inodes that
> inotify will watch. It introduces two new flags. 
> 
> 	IN_ONLYDIR -- only watch the inode if it is a directory
> 	This is needed to avoid the race that can occur when we want to be sure
> that we are watching a directory.
> 
> 	IN_DONT_FOLLOW -- don't follow a symlink. In combination with
> IN_ONLYDIR we can make sure that we don't watch the target of symlinks.
> 
> The issues the flags fix came up when writing the gnome-vfs inotify
> backend. Default behaviour is unchanged.

Looks good to me, and I confirm we hit these issues in real-life with
gnome-vfs.

Acked-by: Robert Love <rml@novell.com>

	Robert Love


