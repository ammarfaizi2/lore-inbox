Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUATNyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUATNye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:54:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13547 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265513AbUATNya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:54:30 -0500
Date: Tue, 20 Jan 2004 14:54:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pascal Schmidt <der.eremit@email.de>, Andries.Brouwer@cwi.nl,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
Message-ID: <20040120135422.GJ2734@suse.de>
References: <Pine.LNX.4.44.0401191945560.976-100000@neptune.local> <Pine.LNX.4.58.0401192331060.2123@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401192331060.2123@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19 2004, Linus Torvalds wrote:
> > Andrew, you can drop the atapi-mo-support patches from -mm if you
> > like. That patch only works with 2048 byte sector discs, while
> > the ide-scsi/sd solution also works with 512 and 1024 byte sector
> > discs.
> 
> I'd really like the ATA cdrom driver to handle different sector sizes 
> properly. There really is no excuse for a block device driver to hardcode 
> its blocksize if it can avoid it.

Agree, it's a bug. Pascal, care to take a stab at fixing it? You're the
most avid ide-cd non-2kb block size user at the moment :)

-- 
Jens Axboe

