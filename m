Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286369AbSAAX2b>; Tue, 1 Jan 2002 18:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286365AbSAAX2W>; Tue, 1 Jan 2002 18:28:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27908 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286362AbSAAX2C>; Tue, 1 Jan 2002 18:28:02 -0500
Date: Tue, 1 Jan 2002 15:27:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: NFS "dev_t" issues..
In-Reply-To: <Pine.GSO.4.21.0201011752200.16467-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201011526330.957-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Jan 2002, Alexander Viro wrote:
>
> Sigh...  Most of the ->i_dev instances are crap and ought to be replaced
> with ->i_sb.  At the very least, let's

Looks good, and yes, it makes a lot more sense from an EXDEV standpoint to
check the superblock, as "i_dev" really has no good meaning for many
filesystems.

		Linus

