Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRKXR1A>; Sat, 24 Nov 2001 12:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRKXR0l>; Sat, 24 Nov 2001 12:26:41 -0500
Received: from imo-m07.mx.aol.com ([64.12.136.162]:60105 "EHLO
	imo-m07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S278808AbRKXR02>; Sat, 24 Nov 2001 12:26:28 -0500
Message-ID: <3BFFD69D.674CF2EE@cs.com>
Date: Sat, 24 Nov 2001 10:19:25 -0700
From: Charles Marslett <cmarslett9@cs.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,zh-TW,ja
MIME-Version: 1.0
To: Phil Howard <phil-linux-kernel@ipal.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com> <20011124103642.A32278@vega.ipal.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Howard wrote:
> OOC, do you think there is any real advantage to the 1m to 4m cache
> that drives have these days, considering the effective caching in
> the OS that all OSes these days have ... over adding that much
> memory to your system RAM?  The only use for caching I can see in
> a drive is if it has physical sector sizes greater than the logical
> sector write granularity size which would require a read-mod-write
> kind of operation internally.  But that's not really "cache" anyway.

Not asked of me, but as always, I do have an opinion:

I think the real reason for the very large disk caches is that the
cost of a track buffer for simple read-ahead is about the same as the
1 MB "cache" on cheap modern drives.  And with very simple logic they
can "cache" several physical tracks, say the ones that contain the inode
and the last few sectors of the most recently accessed file.  Sometimes
this saves you a rotational delay time reading or writing a sector span,
so it can do better than the OS then (I admit, that doesn't happen often).
And the cost/benefit tradeoff is worth it, because the cost is so little.

[Someone who really knows may correct me, however.]

--Charles 
          /"\                           |
          \ /     ASCII Ribbon Campaign |
           X      Against HTML Mail     |--Charles Marslett
          / \                           |  www.wordmark.org
