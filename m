Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265327AbSKAQpc>; Fri, 1 Nov 2002 11:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSKAQpc>; Fri, 1 Nov 2002 11:45:32 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:60548 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265327AbSKAQpb>; Fri, 1 Nov 2002 11:45:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 1 Nov 2002 09:01:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.45/fs/fcblist.c - export symbols for unix
 sockets
In-Reply-To: <20021101032554.A441@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0211010858420.1715-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Adam J. Richter wrote:

> 	linux-2.5.45/fs/fcblist.c contains some symbols that are
> needed for unix domain sockets if unix sockets are compiled as a
> module.  fcblist.o is already in the export-objs declaration in
> fs/Makefile, so I think the intention was for the EXPORT_SYMBOL
> declarations to be in that file.
>
> 	Here is the patch.  I have verified that unix domain sockets
> load with this patch (possibly with some more EXPORT_SYMBOL changes in
> my netsyms.c, which has a bunch of additional exports).
>
> 	Davide: please let me know if this patch is OK (others are
> welcome to comment too), and, if so, if you are going to forward this
> to Linus or if you want me to do something more.

I'll put this in my next patch to Linus. Exports were there in the
original patch ( /dev/epoll ) but after being caught by a cleanup phobia I
nuke them all :)



- Davide


