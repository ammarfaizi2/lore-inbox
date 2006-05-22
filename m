Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWEVPKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWEVPKD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWEVPKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:10:03 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:30422 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750918AbWEVPKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:10:01 -0400
Message-ID: <031001c67db1$a8c4a1e0$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: <nickpiggin@yahoo.com.au>, <cw@f00f.org>, <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <44710144.7090105@yahoo.com.au> <00d201c67d73$220d5d10$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org>
Subject: Re: swapper: page allocation failure.
Date: Mon, 22 May 2006 17:08:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Con Kolivas" <kernel@kolivas.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Haar János" <djani22@netcenter.hu>; "Nick Piggin"
<nickpiggin@yahoo.com.au>; <cw@f00f.org>
Sent: Monday, May 22, 2006 1:17 PM
Subject: Re: swapper: page allocation failure.


> On Monday 22 May 2006 17:41, Haar János wrote:
> > ----- Original Message -----
> > From: "Nick Piggin" <nickpiggin@yahoo.com.au>
> > > Yeah, as I said, block device's pagecache (aka buffercache) can't
> > > use highmem. If nbd can export regular files as block devices, or
> > > you use loop devices from regular files, that might help (or slow
> > > things down :P).
> >
> > Hmm.
> > That sounds bad.
> > I think, if highmem is unreachable some times that makes lowmem more
> > valuable!
> > The kernel needs to keep (reserve) it free as much as possible.
> > The buffer-cache is an unimportant thing next to keeping lowmem free,
but
> > it is blocks the performance and wastes the systems resources!
> >
> > It is possible any workaround?
>
> Try with one of the alternative vmsplit options that gives you more
lowmem?
> That might break certain applications though.

             total       used       free     shared    buffers     cached
Mem:       4049724    4021196      28528          0      16384    3217288
Low:       4049724    4021196      28528
High:            0          0          0
-/+ buffers/cache:     787524    3262200
Swap:            0          0          0

This is an 64 bit machine, the "concentrator".

It looks like use all, the 4G ram as "lowmem".
If i replace the cpu on my nodes to 64bit capable ones, i can use all the
memory as buffer-cache? :-)

Cheers,
Janos



>
> -- 
> -ck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

