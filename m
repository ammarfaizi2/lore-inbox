Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSGOFjY>; Mon, 15 Jul 2002 01:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317339AbSGOFjX>; Mon, 15 Jul 2002 01:39:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63247 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317338AbSGOFjX>; Mon, 15 Jul 2002 01:39:23 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Date: Mon, 15 Jul 2002 05:38:59 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <agtn5j$ij2$1@penguin.transmeta.com>
References: <20020711230222.GA5143@kroah.com>
X-Trace: palladium.transmeta.com 1026711735 26626 127.0.0.1 (15 Jul 2002 05:42:15 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jul 2002 05:42:15 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020711230222.GA5143@kroah.com>, Greg KH  <greg@kroah.com> wrote:
>
>Here's the diffstat output of it:
> drivers/char/Config.help             |   87 
> drivers/char/Config.in               |   15 
> drivers/char/agp/Config.help         |   88 
> drivers/char/agp/Config.in           |   14 
> drivers/char/agp/Makefile            |   13 
> drivers/char/agp/agp.h               |  348 +-
> drivers/char/agp/agpgart_be-ali.c    |  265 ++
> drivers/char/agp/agpgart_be-amd.c    |  408 +++
> drivers/char/agp/agpgart_be-hp.c     |  394 +++
> drivers/char/agp/agpgart_be-i460.c   |  595 ++++
> drivers/char/agp/agpgart_be-i810.c   |  594 ++++
> drivers/char/agp/agpgart_be-i8x0.c   |  720 +++++
> drivers/char/agp/agpgart_be-sis.c    |  142 +
> drivers/char/agp/agpgart_be-sworks.c |  626 +++++
> drivers/char/agp/agpgart_be-via.c    |  151 +

Ok, so is there any real _reason_ to have filenames quite this ugly?

I'd love to have agp split up sanely, but "sanely" does imply that a via
driver is called "via.c", since the "be" part ("backend") is completely
silly (of _course_ a chipset driver is a "backend" driver, it sure as
hell aint frontend), and that "agpgart_" prefix is kind of silly, since
the whole subdirectory is clearly about AGP. 

Having filenames that repeat is redundant, excessive, exorbitant, and
superfluous. 

If you want the redundancy, duplication and profusion, please keep it
shorter.  And put it at the end, so that at least filename completion
works well: "via-agp.c".

Ok?

				Linus
