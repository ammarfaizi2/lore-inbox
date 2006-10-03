Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWJCBGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWJCBGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWJCBGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:06:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030200AbWJCBGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:06:13 -0400
Date: Mon, 2 Oct 2006 18:06:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Nipper <nipsy@bitgnome.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: kernel: pageout: orphaned page with reiserfs v3 in data=journal
 mode under 2.6.18
Message-Id: <20061002180603.b19bfbd0.akpm@osdl.org>
In-Reply-To: <20061002170353.GA26816@king.bitgnome.net>
References: <20061002170353.GA26816@king.bitgnome.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 12:03:54 -0500
Mark Nipper <nipsy@bitgnome.net> wrote:

>         I saw this in my logs earlier today:
> ---
> kernel: pageout: orphaned page
> 
>         It's the first time I've seen it on this box, but I also
> just switched to data=journal mode for all of my reiserfs mounts
> yesterday after a hard drive died in a software RAID-1 volume
> (which incidentally caused some thankfully repairable file system
> damage after a --rebuild-tree seemingly because even though the
> hard drive which was failing was reporting uncorrectable errors
> to the kernel, the software RAID system never failed the drive
> out of the volume but instead kept trying to use it).
> 
>         Anyway, just wondering if the message is bad actually as
> in it indicates some memory leak will bring down my server at
> some point or if it's just a corner case which someone felt the
> need to document whenever it happens.

I think that's a piece of temporary debugging code which I put in there in
a fit of curiosity and which I then promptly forgot about.

It's been in there since March 2005 and you are the first person who has
reported seeing the message...
