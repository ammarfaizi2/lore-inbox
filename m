Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVHORoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVHORoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVHORoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:44:12 -0400
Received: from cramus.icglink.com ([66.179.92.18]:11455 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S964859AbVHORoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:44:11 -0400
Date: Mon, 15 Aug 2005 12:44:04 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: ziggy@icglink.com, scott@icglink.com, jack@icglink.com
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
Message-Id: <20050815124404.089ffe64.phil@icglink.com>
In-Reply-To: <Pine.LNX.4.61.0508142119460.6740@montezuma.fsmlabs.com>
References: <20050811105954.31f25407.phil@icglink.com>
	<17148.1113.664829.360594@cse.unsw.edu.au>
	<20050812123505.1515634c.phil@icglink.com>
	<20050812183548.GA2255@kevlar.burdell.org>
	<20050814210331.102e005c.phil@icglink.com>
	<Pine.LNX.4.61.0508142031510.6740@montezuma.fsmlabs.com>
	<1124075282.13401.116.camel@phantasy>
	<Pine.LNX.4.61.0508142119460.6740@montezuma.fsmlabs.com>
Organization: ICGLink
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 21:20:35 -0600 (MDT)
Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

> On Sun, 14 Aug 2005, Robert Love wrote:
> 
> > On Sun, 2005-08-14 at 20:40 -0600, Zwane Mwaikambo wrote:
> > 
> > > I'm new here, if the inode isn't being watched, what's to stop d_delete 
> > > from removing the inode before fsnotify_unlink proceeds to use it?
> > 
> > Nothing.  But check out
> > 
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7a91bf7f5c22c8407a9991cbd9ce5bb87caa6b4a
> 
> That git web interface looks rather spiffy.
> 
> > Should solve this problem?
> 
> Seems to fit the bill perfectly.
> 
> Thanks,
> 	Zwane
> 


So, for the record, I patched my 2.6.13-rc6 kernel with the patch at this location:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=7a91bf7f5c22c8407a9991cbd9ce5bb87caa6b4a;hp=1963c907b21e140082d081b1c8f8c2154593c7d7

and I will be testing it today.


Thanks to all of you guys.

-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
