Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSFCTEt>; Mon, 3 Jun 2002 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSFCTEs>; Mon, 3 Jun 2002 15:04:48 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2463 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317458AbSFCTEq>;
	Mon, 3 Jun 2002 15:04:46 -0400
Date: Mon, 3 Jun 2002 12:19:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: do_mmap
Message-ID: <20020603121943.A37@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.05.10205311456070.10633-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> what about the do_mmap/do_mmap_pgoff implementation?
> reurn-type: _unsigned_ long	(which should be ok cause we've to return
> 				 an adress if len == 0)
> on error: -ERR_*
> 
> and the checks in various places are really strange. - well some
> places check for:
> 	o != NULL
> 	o > -1024UL
> 	o ...
> 
> guess this nedds some cleanup.

While you are at it... fs/binfmt_elf does mmaps but does not check for errors.
And errors actually do happen there :-(

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

