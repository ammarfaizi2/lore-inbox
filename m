Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVCYRx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVCYRx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCYRx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:53:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55247 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261705AbVCYRxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:53:55 -0500
Date: Fri, 25 Mar 2005 12:52:33 -0500
From: Bill Nottingham <notting@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad caching behavior in 2.6.12rc1
Message-ID: <20050325175233.GA15370@nostromo.devel.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050324232731.GA14812@nostromo.devel.redhat.com> <20050324153813.5ee0ab1f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324153813.5ee0ab1f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@osdl.org) said: 
> > Test box is a 1.5GB laptop.
> > 
> > In typical use, I would open a mailbox A, and then switch
> > to mailbox B. Immediately switching back to mailbox A, I
> > would find out it was no longer cached. (Using maildirs,
> > FWIW.)
> > 
> > Looking at /proc/meminfo, I would see:
> > 
> > LowFree: 8-12MB
> > HighFree: 300-400MB
> > Cached: 100-200MB
> > 
> > i.e., it was evicting cache when there was plenty of highmem
> > available for use.
> 
> Where's the rest of the memory gone?  A full /proc/meminfo would be useful.

In the manner of all good bugs, as soon as I tried to reproduce it, it's
hiding. I can get it to this point (very little lowfree, lots of highfree,
medium amounts of cache); but now the cache is behaving more as expected.

Feel free to ignore it until I can duplicate it again. :)

Bill
