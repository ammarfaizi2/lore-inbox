Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVITE42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVITE42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVITE42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:56:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932517AbVITE41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:56:27 -0400
Date: Mon, 19 Sep 2005 21:56:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <20050920044623.GD7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509192154020.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
 <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
 <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
 <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
 <20050920044623.GD7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Al Viro wrote:
> 
> 	Could you please describe the semantics of your events?

I think the good news is that we can make up the exact semantics. This 
thing is used by things like file managers etc, and we've had very fuzzy 
semantics on inotify, while the new dnotify is totally new.

So it's a give-and-take of "what are the semantics people want" and "what
are reasonable semantics from the kernel VFS standpoint". I suspect we're
slowly converging on something that works for both parties ;)

			Linus
