Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTBXQxN>; Mon, 24 Feb 2003 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTBXQxM>; Mon, 24 Feb 2003 11:53:12 -0500
Received: from angband.namesys.com ([212.16.7.85]:31363 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267227AbTBXQxL>; Mon, 24 Feb 2003 11:53:11 -0500
Date: Mon, 24 Feb 2003 20:03:23 +0300
From: Oleg Drokin <green@namesys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, vs@namesys.com, nikita@namesys.com,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4 (supposedly fixed NFS version this time)
Message-ID: <20030224200323.A18408@namesys.com>
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com> <20030221200440.GA23699@delft.aura.cs.cmu.edu> <20030224132145.A7399@namesys.com> <15962.19783.182617.822504@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15962.19783.182617.822504@charged.uio.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 24, 2003 at 05:50:15PM +0100, Trond Myklebust wrote:
>      >     Original patch was from Jan Harkes <jaharkes@cs.cmu.edu>,
>      >     and was applied somewhere at the beginning of 2.5
>      >     development.  It still would be nice if someone more
>      >     knowledgeable in NFS client code will review the changes
>      >     (and the same is true for Coda of course).
> Please remind me. Why can't NFS set inode->i_mode, call
> nfs_fill_inode() etc. in the 'init_locked' callback?

Well, it seems there is no reason against that.

> As for the issue of the stat() problem you mentioned: does your server
> have a monotonically increasing inode->i_ctime? If ntp or something

I think it have.

> like that keeps turning the clock backward on the server, then the NFS
> client has no chance of recognizing which attribute updates are the
> more recent ones.

Ok, I stopped ntpd. Will see what will happen. ;)
Aha, it died already:
doread: read: Input/output error

How about that "RPC request reserved 1144 but used 4024" alike stuff"?

Bye,
    Oleg
