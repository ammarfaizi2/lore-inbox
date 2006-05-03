Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWECQiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWECQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWECQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:38:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9137 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965238AbWECQiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:38:15 -0400
Date: Wed, 3 May 2006 18:38:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jared Hulbert <jaredeh@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Advanced XIP File System
In-Reply-To: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What is it?:
> - Borrows much from CRAMFS with Linear XIP patches

Apropos borrowing: borrow the compression from Squashfs.

> I've heard people say, "XIP is stupid.  Why on earth would I use
> expensive slow flash instead of cheap fast RAM?"
> [...]  If I
> take libfoo.so which is about 2MiB and throw it in JFFS2, it
> compresses to about 1MiB in flash.  If I store libfoo.so as an XIP
> file (uncompressed) in XIP CRAMFS or AXFS it takes up 2MiB of flash. That is
> 1MiB extra flash for XIP.  But the JFFS2 version would need
> 2MiB of RAM to store that library when used while the XIP system uses
> 0MiB. That means XIP uses +1MiB of flash and -2MiB of RAM for
> libfoo.so.  So for any extra flash used for XIP, it can save twice
> that amount of RAM.  The end result can be lower cost systems on the
> small end.  The secret is to choose what to make XIP and what to
> compress on flash.

If 2 MB of RAM are cheaper [as you say] than 1 MB of Flash, where's the 
advantage when XIP uses more flash?


Jan Engelhardt
-- 
