Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTBCLDK>; Mon, 3 Feb 2003 06:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTBCLDK>; Mon, 3 Feb 2003 06:03:10 -0500
Received: from angband.namesys.com ([212.16.7.85]:40585 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265939AbTBCLDJ>; Mon, 3 Feb 2003 06:03:09 -0500
Date: Mon, 3 Feb 2003 14:12:36 +0300
From: Oleg Drokin <green@namesys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Ford <david+powerix@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@digeo.com>
Subject: Re: NFS problems, 2.5.5x
Message-ID: <20030203141236.A18736@namesys.com>
References: <3E3B2D2E.8000604@blue-labs.org> <15931.35891.22926.408963@charged.uio.no> <3E3BEFDB.3060208@blue-labs.org> <15931.62606.441404.74917@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15931.62606.441404.74917@charged.uio.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Feb 01, 2003 at 05:23:42PM +0100, Trond Myklebust wrote:
>      > The last time NFS was working, I had 2.4.19 and 2.5.53 clients
>      > on a
>      > 2.5.59 server, that was yesterday.  I had experienced a slight
>      >        problem
>      > with it last week when my 2.5.53 client was booted for first
>      > time on 2.5.5x, it was previously a 2.4 kernel.  The server
>      > OOPSed repeatedly shortly after bootup in NFS stuff then it
>      > never happened again and was rock solid until today.
> So have you tried out the 2.5.53 client since you noticed this
> problem?

While trying to reproduce mounting of reiserfs FS over NFS from 2.5.59 server,
trying to see if there is something to do with reiserfs itself (and it worked
perfectly with 2.4.19 client), I decided to try to mount it from this same
workstation as I did not had 2.5.59 client at hand.
This way I learned that mount localhost:/exportedfs /mnt -t nfs
(localhost can be replaced by any local IP) results in mount
hanging in D state:
100     0   775   770  15   0  1532  620 rpc_ex D    pts/1      0:00 mount 212.16.7.78:/home /mnt -t nfs

At the same time I still can mount it from external hosts (but cannot kill this hung mount, obviously).

This is on today's 2.5.529 bk snapshot.

Bye,
    Oleg
