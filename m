Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSKCAlq>; Sat, 2 Nov 2002 19:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSKCAlq>; Sat, 2 Nov 2002 19:41:46 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:60838 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261524AbSKCAlp>; Sat, 2 Nov 2002 19:41:45 -0500
Date: Sat, 2 Nov 2002 22:47:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0211022245060.3411-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Linus Torvalds wrote:
> On Sat, 2 Nov 2002, Rik van Riel wrote:
> >
> > Sure it's more flexible, but I wonder how many userland
> > programs will be broken if we change the permission model
> > and how well users can protect their data this way.
>
> This is not a "change". Existing behaviour clearly cannot change. We're
> talking about new interfaces to export capabilities in the filesystem.
>
> And pathnames are a _hell_ of a lot better and straightforward interface
> than inode numbers are. It's confusing when you change the permission on
> one path to notice that another path magically changed too.

It's also going to be confusing when you change permissions on
an inode and the extended attributes in one of the paths to the
inode don't change with it.

It'd be confusing as hell if I did a 'chmod go-r' on a file I
own, but have others continue reading the file because of some
extended attributes giving them the rights to do so.

Or am I misunderstanding the kinds of extended attributes you
want to have determined by pathname instead of by inode ?

It'd be nice to have an overview of exactly which permissions
and attributes are per file and which are per pathname ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

