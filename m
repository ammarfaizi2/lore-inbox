Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWCEBnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWCEBnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 20:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWCEBnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 20:43:41 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:61130 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932082AbWCEBnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 20:43:41 -0500
Date: Sun, 5 Mar 2006 04:43:25 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: jengelh@linux01.gwdg.de, christopher.leech@intel.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Message-ID: <20060305014324.GA20026@2ka.mipt.ru>
References: <20060303214036.11908.10499.stgit@gitlost.site> <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr> <20060304.134144.122314124.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304.134144.122314124.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 05 Mar 2006 04:43:26 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 01:41:44PM -0800, David S. Miller (davem@davemloft.net) wrote:
> From: Jan Engelhardt <jengelh@linux01.gwdg.de>
> Date: Sat, 4 Mar 2006 19:46:22 +0100 (MET)
> 
> > Does this buy the normal standard desktop user anything?
> 
> Absolutely, it optimizes end-node performance.

It really depends on how it is used.
According to investigation made for kevent based FS AIO reading,
get_user_pages() performange graph looks like sqrt() function
with plato starting on about 64-80 pages on Xeon 2.4Ghz with 1Gb of ram,
while memcopy() is linear, so it can be noticebly slower than
copy_to_user() if get_user_pages() is used aggressively, so userspace
application must reuse the same, already grabbed buffer for maximum
performance, but Intel folks did not provide theirs usage case and any
benchmarks as far as I know.

-- 
	Evgeniy Polyakov
