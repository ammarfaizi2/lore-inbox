Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281512AbRLLRhe>; Wed, 12 Dec 2001 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281557AbRLLRhZ>; Wed, 12 Dec 2001 12:37:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:7 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281512AbRLLRhK>; Wed, 12 Dec 2001 12:37:10 -0500
Date: Wed, 12 Dec 2001 14:20:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: GOTO Masanori <gotom@debian.org>
Cc: tachino@open.nm.fujitsu.co.jp, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <w53lmg9glwn.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.LNX.4.21.0112121420420.27221-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, GOTO Masanori wrote:

> At Wed, 12 Dec 2001 11:46:29 +0900,
> Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp> wrote:
> > At Tue, 11 Dec 2001 17:46:01 -0800 (PST),
> > Linus Torvalds wrote:
> > > 
> > > 
> > > On Wed, 12 Dec 2001, Tachino Nobuhiro wrote:
> > > >
> > > > But my patch fixes another bug. Current /dev/ram* does not return -ENOSPC
> > > > at the end of device size because generic_file_write() also checks whether
> > > > mapping->host is a block device. So I think the patch is required.
> > > 
> > > I'll agree with your one-liner: it's good practice anyway to initialize
> > > any fields that could ever be looked at. I actually already applied it to
> > > my tree, I just want to make sure that people don't apply the other
> > > patch..
> > > 
> > > 		Linus
> > 
> > Thank you.
> > 
> > I think the patch should be applied to 2.4 because "dd if=/dev/zero of=/dev/ram1"
> > can cause system hang easily.
> 
> Linus, Tachino, your patch are both right.
> I was not aware mapping inode used block file inode... Umm.
> 
> In my test, it works fine for both block device and file, and resolves
> "inode->i_dev" and block size problems.
> Thank you for your (simple and complete) patch! I'm now happy :)
> 
> > Marcelo, please consider applying the patch.
> 
> Yes. Would you remove my previous patches and apply these patches ?

Yes, I will do that for -rc1.

