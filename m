Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWEVHmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWEVHmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWEVHmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:42:09 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:9157 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932591AbWEVHmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:42:08 -0400
Message-ID: <00d201c67d73$220d5d10$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <cw@f00f.org>, <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs> <20060521102642.GB5582@taniwha.stupidest.org> <44705699.3080401@yahoo.com.au> <024901c67cdf$1e1ce840$1800a8c0@dcccs> <44710144.7090105@yahoo.com.au>
Subject: Re: swapper: page allocation failure.
Date: Mon, 22 May 2006 09:41:23 +0200
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
From: "Nick Piggin" <nickpiggin@yahoo.com.au>
To: "Haar János" <djani22@netcenter.hu>
Cc: "Chris Wedgwood" <cw@f00f.org>; <linux-kernel@vger.kernel.org>
Sent: Monday, May 22, 2006 2:09 AM
Subject: Re: swapper: page allocation failure.


> Haar János wrote:
>
> > I did it allready, and it looks like solves the problem.
> > Yesterday i have more than 6 random reboots, and after i set from 3800
to
> > 16000 the min free limit, i have none at this point. :-)
> >
> >  15:51:45 up  7:21,  1 user,  load average: 0.85, 0.79, 0.67
>
> Oh that's good. It's sad that you had random reboots though :(

09:12:44 up 1 day, 43 min,  1 user,  load average: 0.48, 0.44, 0.42

It really fixes this issue. :-)

Thanks to you all!

>
> >
> > Anyway, i interested about cache/buffer mechanism, because i have some
> > performance problems too, and i can see, these systems wastes the half
of
> > memory instead of speeds up the operation.
>
> Yeah, as I said, block device's pagecache (aka buffercache) can't
> use highmem. If nbd can export regular files as block devices, or
> you use loop devices from regular files, that might help (or slow
> things down :P).

Hmm.
That sounds bad.
I think, if highmem is unreachable some times that makes lowmem more
valuable!
The kernel needs to keep (reserve) it free as much as possible.
The buffer-cache is an unimportant thing next to keeping lowmem free, but it
is blocks the performance and wastes the systems resources!

It is possible any workaround?

The NBD is finally fixed, and production ready.
The big systems should use it, because it is easy.
Additionally the big system usually needs the maximum of performance.....
(+ the good cache/buffer extends the hardware lifetime.)

I think it is important to be changed.

(e.g. i use 4 nodes, 4x 3.3TB to use it as one big blockdev.)

Cheers,
Janos

>
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

