Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVKHSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVKHSLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbVKHSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:11:04 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:46284 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S965207AbVKHSLC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:11:02 -0500
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Arnd Bergmann <arnd@arndb.de>, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	<20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
	<20051108105923.GA31446@wohnheim.fh-wedel.de>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: Tue, 08 Nov 2005 11:10:27 -0700
In-Reply-To: <20051108105923.GA31446@wohnheim.fh-wedel.de> (
 =?iso-8859-1?q?J=F6rn_Engel's_message_of?= "Tue, 8 Nov 2005 11:59:24
 +0100")
Message-ID: <m3zmofovsc.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> Moving crap over to mtdchar.c is a good thing.  Complete removal of
> mtdchar.c might be even better, but at least the crap is relatively
> self-contained now.

Agreed moving the compat_ioctl to mtdchar now that it is possible
sounds good.

I can see that argument with respect to mtdblock.  But why would
removal of mtdchar be a good thing?  It is a simple raw access
interface.   For those whose flash parts are too small for a filesystem
or when you are doing things that you can't do with a filesystem
like making or checking it you need something like mtd char.  For
embedded folks who don't care you can just compile it out.


Eric
