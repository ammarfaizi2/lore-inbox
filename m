Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVD2Uux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVD2Uux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVD2Usy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:48:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38571 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262939AbVD2Ur7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:47:59 -0400
Subject: Re: which ioctls matter across filesystems
From: Robert Love <rml@novell.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1114807360.12692.77.camel@lade.trondhjem.org>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
	 <1114805033.6682.150.camel@betsy>
	 <1114807360.12692.77.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:47:28 -0400
Message-Id: <1114807648.6682.153.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 16:42 -0400, Trond Myklebust wrote:

> The problem is that having the server call back a bunch of clients every
> time a file changes does not really scale too well. The current
> dnotify-like proposal therefore specifies that notification is not
> synchronous (i.e. there may be a delay of several seconds), and that the
> server may want to group several notifications into a single callback.

Yah, so what I am asking is why not use inotify for the user-side
component of this system?

Wouldn't the deferring and coalescing of events occur on the server
side?  So the server-side stuff would be whatever you need--your own
code using whatever protocol you wanted--but the client-side interface
would be over inotify.

Even if not, I'd be willing to make changes to inotify to accommodate
NFS's needs.

	Robert Love


