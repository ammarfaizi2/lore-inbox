Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129141AbRBFApC>; Mon, 5 Feb 2001 19:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRBFAow>; Mon, 5 Feb 2001 19:44:52 -0500
Received: from winds.org ([207.48.83.9]:35588 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129141AbRBFAok>;
	Mon, 5 Feb 2001 19:44:40 -0500
Date: Mon, 5 Feb 2001 19:43:04 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
In-Reply-To: <14975.15829.623996.534161@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0102051935270.1746-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Neil Brown wrote:

> How repeatable is this?  Is the server SMP?

I've tested this on two UP Athlons and 2 SMP Pentium 3's and the same problem
occurred. I have not tested it more than once on the same system (I left the
NFS servers untouched after the reboot).

The Athlon systems running NFS were 2.4.1-ac3 and the Pentiums were running
2.2.19-pre7. All computers exporting the FS had one directory mounted at least
once.

In one case, only 1 directory was mounted once and then unmounted before
shutting off the NFS server. When I realized I forgot to copy a directory over,
I went to restart NFS on the server and found out I was unable to. Probably
irrelevant, but this had been after transferring 7 gigs of data over 100 Mbps.

I still have the 'broken' server running, so if you would like me to run a
command or two on it I can show you the results.

> The attached patch might fix it, so if you are having reproducable
> problems, it might be worth applying this patch.

I can try it tomorrow and see if it fixes the problem, but since this problem
also occurred on a UP, using spin locks probably will not correct it. Perhaps
it's something else.

> [patch snipped]

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
