Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbTDBHor>; Wed, 2 Apr 2003 02:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbTDBHor>; Wed, 2 Apr 2003 02:44:47 -0500
Received: from sj-core-2.cisco.com ([171.71.177.254]:48635 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S262432AbTDBHoq>; Wed, 2 Apr 2003 02:44:46 -0500
From: "Hua Zhong" <hzhong@cisco.com>
To: "Christoph Rohland" <cr@sap.com>, "Daniel Egger" <degger@fhm.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Tue, 1 Apr 2003 23:55:26 -0800
Message-ID: <CDEDIMAGFBEBKHDJPCLDCECBDGAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <ovfzp1l6cc.fsf@sap.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is at least one case that ramfs works but tmpfs doesn't.

If you have a loopback file A, and the following will fail in 2.4:

mount -t tmpfs tmpfs /mnt/tmp
extract file A to /mnt/tmp/A
mount -t ext2 -o loop /mnt/tmp /mnt/loopback

You'll get "ioctl: LOOP_SET_FD: Invalid argument".

But ramfs works great.

Is this a bug or feature?

> Uuh, now you are beating me with my old statements ;-)
>
> tmpfs has the drawback that the in memory data structures are bigger
> than ramfs'. But the core of tmpfs is always compiled in for anonymous
> shared memory. And it has size limits. So you are probably right, that
> tmpfs is the right choice.
>
> But you are arguing at a corner case. tmpfs is IMHO more often used on
> machines with swap and (at least for me) the use of swap as store for
> temporary data is the big point to use tmpfs. So the percentile should
> take swap into account.
>
> Greetings
> 		Christoph
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

