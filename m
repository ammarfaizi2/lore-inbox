Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVEXQk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVEXQk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVEXQiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:38:25 -0400
Received: from loon.tech9.net ([69.20.54.92]:35459 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S262147AbVEXQfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:35:24 -0400
Subject: Re: inotify 0.23 errno 28 (ENOSPC)
From: Robert Love <rlove@rlove.org>
To: bryanwilkerson@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050524163309.74541.qmail@web53401.mail.yahoo.com>
References: <20050524163309.74541.qmail@web53401.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 12:35:20 -0400
Message-Id: <1116952520.13324.38.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 09:33 -0700, Bryan Wilkerson wrote:

> I read an earlier thread where you said that it was
> possible to manually walk a tree and add all
> directories to an inotify watch descriptor.  I wrote
> some code to do this and the ioctl call fails on my
> machine after adding 9,977 directories with ENOSPC.  
> 
> I've attached a small repro case.  Just point it at
> the base of a large dir tree (e.g. inotify-r ~) to
> use. 
> 
> My kernel is 2.6.12-rc3 with the inotify 0.23 patch. 
> Let me know if you need more information.  

This is intended.  There is a per-user limit on the number of watches.
By default, that limit is 8192.

You can view and edit the number via
	/sys/class/misc/inotify/max_user_watches

Best,

	Robert Love


