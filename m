Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTEHQPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTEHQPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:15:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261743AbTEHQPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:15:22 -0400
Date: Thu, 8 May 2003 09:27:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030508161600.GE20941@suse.de>
Message-ID: <Pine.LNX.4.44.0305080924400.2967-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Jens Axboe wrote:
> 
> Maybe a define or two would help here. When you see drive->addressing
> and hwif->addressing, you assume that they are used identically. That
> !hwif->addressing means 48-bit is ok, while !drive->addressing means
> it's not does not help at all.

Why not just change the names? The current setup clearly is confusing, and
adding defines doesn't much help. Rename the structure member so that the
name says what it is, aka "address_mode", and when renaming it you'd go
through the source anyway and change "!addressing" to something more
readable like "address_mode == IDE_LBA48" or whatever.

(Anyway, I'll just drop all the 48-bit patches for now, since you've 
totally confused me about which ones are right and what the bugs are ;)

		Linus

