Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUATHdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUATHdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:33:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:15511 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265253AbUATHdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:33:04 -0500
Date: Mon, 19 Jan 2004 23:32:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
In-Reply-To: <Pine.LNX.4.44.0401191945560.976-100000@neptune.local>
Message-ID: <Pine.LNX.4.58.0401192331060.2123@home.osdl.org>
References: <Pine.LNX.4.44.0401191945560.976-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jan 2004, Pascal Schmidt wrote:
> 
> This patch seems to solve all my 2.6 ide-scsi problems.

I've applied the fix part of it and pushed it out. If Andries wants to
re-send the whitespace fixes, I can apply those too, but I hate applying 
patches like this where the whitespace fixes hide the real fix.

> Andrew, you can drop the atapi-mo-support patches from -mm if you
> like. That patch only works with 2048 byte sector discs, while
> the ide-scsi/sd solution also works with 512 and 1024 byte sector
> discs.

I'd really like the ATA cdrom driver to handle different sector sizes 
properly. There really is no excuse for a block device driver to hardcode 
its blocksize if it can avoid it.

		Linus
