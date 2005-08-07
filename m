Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVHGCvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVHGCvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 22:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVHGCvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 22:51:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3007 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750773AbVHGCvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 22:51:44 -0400
Date: Sun, 7 Aug 2005 12:51:22 +1000
From: Greg Banks <gnb@sgi.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.xx - NFSv3 vs. Samba Data Transfer Semantics
Message-ID: <20050807025121.GA26391@sgi.com>
References: <Pine.LNX.4.63.0508061017150.19178@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508061017150.19178@p34>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 10:34:55AM -0400, Justin Piszcz wrote:
> UDP/NFSv3:

Don't use UDP.  It won't help you with this problem, but use TCP.

> UDP/Samba, Win2K->Linux box:
  ^^^
That would be a surprise.

>   When NFS transfers are taking 
> place, watching gkrellm, I see 64MB/s for a few seconds then it goes to 0 
> as the disk (hda) continues to write for 3-4 seconds, this continues on 
> and off.  

It's instructive to watch the server's disk traffic on a graph with the
same timescale as the network traffic.

> I am using XFS filesystems on both Linux machines.  The drives are 7200RPM 
> Seagate HDDs with either 2MB or 8MB of cache.

With a single drive, your transfer rate is going to be disk limited 
to probably 40-50 MB/s anyway.

> Are there any 'tweaks' or 'hacks' to make NFS behave more like Samba or 

The 'async' export option.  RTFM before you use it.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
