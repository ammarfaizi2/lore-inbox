Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319400AbSILBev>; Wed, 11 Sep 2002 21:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319401AbSILBev>; Wed, 11 Sep 2002 21:34:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:52142 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319400AbSILBeu>;
	Wed, 11 Sep 2002 21:34:50 -0400
Message-ID: <3D7FF3E7.61772A26@digeo.com>
Date: Wed, 11 Sep 2002 18:54:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
References: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com> <20020911171934.GA12449@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 01:39:32.0239 (UTC) FILETIME=[3E0C59F0:01C259FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> 
> ...
> Again. We have 2^30 = 10^9 pids. In reality there are fewer than 10^4
> processes. So once in 10^5 pid allocations do we make a scan over
> these 10^4 processes,

Inside tasklist_lock?  That's pretty bad from a latency point of
view.  A significant number of users would take the slower common
case to avoid this.
