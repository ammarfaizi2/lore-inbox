Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRHBOaA>; Thu, 2 Aug 2001 10:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268959AbRHBO3u>; Thu, 2 Aug 2001 10:29:50 -0400
Received: from Expansa.sns.it ([192.167.206.189]:40201 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268957AbRHBO3i>;
	Thu, 2 Aug 2001 10:29:38 -0400
Date: Thu, 2 Aug 2001 16:27:03 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: <nbecker@fred.net>, <linux-kernel@vger.kernel.org>
Subject: Re: re-export nfs possible?
In-Reply-To: <15208.45277.787888.292427@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33.0108021623330.25222-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Neil Brown wrote:

> On  August 1, nbecker@fred.net wrote:
> > Is it possible to mount a fs via nfs, and then reexport it via nfs?
>
> No.
>
> The protocol doesn't really support it, and the (Linux-kernel)
> implementation definately doesn't support it.
definitelly the kernel implementation cannot manage the loops a re-export
would imply.
>
> I think the user-space nfs server can do it.  It has other problems,
> but it might work for you.
yes, you have to run both rpc.mountd and rpc.nfsd with the -r option.I
used this one year ago, and it was really stable with 10 nfs clients
(physicaly the partition was on an AIX server, mounted on a linux server
and then re-exported on many linux clients), but the physical FS status
could not be really coherent in front of what the nfs re-export server
thinks it should be.

Luigi


