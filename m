Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTL3Xuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTL3Xuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:50:51 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:26286 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264387AbTL3Xuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:50:50 -0500
Date: Tue, 30 Dec 2003 15:50:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slab allocator . . . cache?  WTF is it?
Message-ID: <20031230235029.GY1882@matchmail.com>
Mail-Followup-To: john moser <bluefoxicy@linux.net>,
	linux-kernel@vger.kernel.org
References: <20031230221859.15F503956@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230221859.15F503956@sitemail.everyone.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 02:18:58PM -0800, john moser wrote:
> I'm wondering, what IS cache?  It seems to increase even when swap is not used,
> and sometimes when there's no swap partition enabled.  It also seems to cause
> me to run into swap when I have ample ram available, assuming that cache is just
> some sort of cache that is copied from and mirrors another portion of ram for
> some sort of speed increase.  

First of all, does it swap out and stay swapped out, or does it swap in and
out constantly?

What kernel version are you running?

The cache, or pagecache is at the core of Linux' memory management.  When
you start an application (or process) it first maps the file into the cache,
and then executes it.  So the cached value also counts the parts of the
files used recently.  It gets much more complicated, but you're invited to
learn more about it.  I'm sure someone else can give you a few URLs with
more details.

