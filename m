Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbSI3Hsr>; Mon, 30 Sep 2002 03:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261957AbSI3Hsr>; Mon, 30 Sep 2002 03:48:47 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41601 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261956AbSI3Hsq>; Mon, 30 Sep 2002 03:48:46 -0400
Date: Mon, 30 Sep 2002 00:51:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
cc: Anton Blanchard <anton@samba.org>
Subject: Re: 2.5.39-mm1
Message-ID: <735786955.1033347097@[10.10.2.3]>
In-Reply-To: <3D976206.B2C6A5B8@digeo.com>
References: <3D976206.B2C6A5B8@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I must say that based on a small amount of performance testing the
> benefits of the cache warmness thing are disappointing. Maybe 1% if
> you squint.  Martin, could you please do a before-and-after on the
> NUMAQ's, double check that it is actually doing the right thing?

Seems to work just fine:

2.5.38-mm1 + my original hot/cold code.
Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%

2.5.39-mm1
Elapsed: 19.532s User: 192.25s System: 42.642s CPU: 1203.2%

And it's a lot more than 1% for me ;-) About 12% of systime
on kernel compile, IIRC.

M.



