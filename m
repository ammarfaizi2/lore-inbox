Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSLGXe2>; Sat, 7 Dec 2002 18:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSLGXe2>; Sat, 7 Dec 2002 18:34:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:57823 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264920AbSLGXe1>;
	Sat, 7 Dec 2002 18:34:27 -0500
Message-ID: <3DF28748.186AB31F@digeo.com>
Date: Sat, 07 Dec 2002 15:42:00 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
References: <3DF2844C.F9216283@digeo.com> <20021207.153045.26640406.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 23:42:00.0630 (UTC) FILETIME=[3CE67560:01C29E4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Sat, 07 Dec 2002 15:29:16 -0800
> 
>    Jeff Garzik wrote:
>    > Attached is cut #2.  Thanks for all the near-instant feedback so far :)
>    >   Andrew, does the attached still need padding on SMP?
> 
>    It needs padding _only_ on SMP.  ____cacheline_aligned_in_smp.
> 
> non-smp machines lack L2 caches?  That's new to me :-)
> 
> More seriously, there are real benefits on non-SMP systems.

Then I am most confused.  None of these fields will be put under
busmastering or anything like that, so what advantage is there in
spreading them out?
