Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTKLRcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbTKLRcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:32:52 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:1213 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263846AbTKLRcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:32:51 -0500
Date: Wed, 12 Nov 2003 18:32:40 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311111706530.1694-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311121830260.942-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:

> Which is what ide-cd.c will fall back to as well ("cdrom_read_capacity()")
> but I think it should _start_ with that rather than fall back on it.
> That's the simple case, after all.
> 
> Does it work if you change the order of those two things in ide-cd.c (or
> just remove the call to "cdrom_get_last_written()" entirely, so that it
> always just does the sane thing).

In my case, we don't get as far as the cdrom_last_written() call in
cdrom_read_toc(). I will try putting the cdrom_read_capacity() stuff
on top and see if that works.

-- 
Ciao,
Pascal

