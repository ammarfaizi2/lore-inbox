Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbUKUSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUKUSfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUKUSfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:35:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33740 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261781AbUKUSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:35:07 -0500
Date: Sun, 21 Nov 2004 19:13:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041121181345.GB729@openzaurus.ucw.cz>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So I would go along the lines of 2).  However there is no way to know
> when pages are dirtied (ther is no fault), so accounting the dirty
> pages exactly is not possible.  However accounting the _writable_
> pages should be possible with no overhead, since there is a fault when
> the page of a mapping is first touched.

Ugh, this is going to be "interesting". Perhaps it can have little overhead,
but hacking pagefault handlers is going to be hard.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

