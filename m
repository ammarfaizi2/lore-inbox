Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSJaW5d>; Thu, 31 Oct 2002 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265479AbSJaW5c>; Thu, 31 Oct 2002 17:57:32 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:36359 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S265477AbSJaW5b>; Thu, 31 Oct 2002 17:57:31 -0500
Date: Thu, 31 Oct 2002 23:03:43 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Hans Reiser <reiser@namesys.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reiser vs EXT3
In-Reply-To: <3DC1A925.1000703@pobox.com>
Message-ID: <Pine.LNX.4.33.0210312258161.6668-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jeff Garzik wrote:

> > reiser4 is 7.6 times the write performance of ext3
> > for 30 copies of the linux kernel source code using modern IDE drives

> What is the read performance like?
>
> write performance isn't the end-all be-all of useful benchmarks,
> because most servers do far more reading in a day than they will ever
> write.

I'm not sure how true that is these days.  OLTP DB servers
with a lot of RAM will typically do more write traffic, all
pushed by fsync, than reads.  (Some may claim that that
means your server is overspecced, of course.)

Other servers, too, look rather like that -- mail servers
do a lot of fsync, web servers generally have smallish web
trees but write a lot of logs...

Even on data warehousing apps, there will be a fairly high
level of writes due to use of temporary relations..

Matthew.

