Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVGMT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVGMT1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVGMTZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:25:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:30598 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262646AbVGMTNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:13:09 -0400
Subject: Re: supporting functions missing from inotify patch
From: Robert Love <rml@novell.com>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121280212.5544.46.camel@stevef95.austin.ibm.com>
References: <1121280212.5544.46.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 15:12:42 -0400
Message-Id: <1121281962.6384.36.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 13:43 -0500, Steve French wrote:

> I don't see an inode operation for registering inotify events in the fs
> (there is a file operation for dir_notify to register its events).  In
> create_watch in fs/inotify.c I expected to see something like:

Why not use the existing dir_notify method?  No point in adding another.

Add inotify hooks as needed to your filesystem's dir_notify.

> I also don't see exports for 
> 	fsnotify_access
> 	fsnotify_modify
> 
> Without these exports, network and cluster filesystems can't notify the
> local system about changes.

Eh?

They are in <linux/fsnotify.h>.

	Robert Love


