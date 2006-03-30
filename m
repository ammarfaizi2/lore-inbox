Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWC3OFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWC3OFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWC3OFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:05:22 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5092 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932215AbWC3OFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:05:21 -0500
Date: Thu, 30 Mar 2006 23:05:09 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060330230509.b1ae0d8c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060330135346.GL13476@suse.de>
References: <20060329122841.GC8186@suse.de>
	<20060330175406.fbd6d82c.kamezawa.hiroyu@jp.fujitsu.com>
	<20060330135346.GL13476@suse.de>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006 15:53:46 +0200
Jens Axboe <axboe@suse.de> wrote:

> > I don't know about sendfile() but this looks client can hold server's
> > memory, when server uses sendfile() 64k/conn.
> 
> You mean when the server uses splice, 64kb (well 16 pages actually) /
> connection? That's a correct observation, I wouldn't think that pinning
> that small a number of pages is likely to cause any issues. At least I
> can think of much worse pinning by just doing IO :-)
> 
My point is consumer can sleep forever and pages are pinnded forever.
And people who use splice() will not notice they are pinning pages.

But as you say, it's not problem in usual situation.
Maybe I'm too pessimistic how my cusomers play with Linux ;)

-- Kame

