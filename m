Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbSKQS7q>; Sun, 17 Nov 2002 13:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSKQS7q>; Sun, 17 Nov 2002 13:59:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:49290 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267578AbSKQS7p>;
	Sun, 17 Nov 2002 13:59:45 -0500
Date: Sun, 17 Nov 2002 14:06:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@lst.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [PATCH] change allow_write_access/deny_write_access prototype
In-Reply-To: <20021117193100.A6763@lst.de>
Message-ID: <Pine.GSO.4.21.0211171404490.23400-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Nov 2002, Christoph Hellwig wrote:

> Make them take an inode instead of a file, this way we don't need
> to derefence struct dentry in fs.h and with a few more steps we can
> get rid of dcache.h in fs.h
> 

	Stop.  Quite a few things of the same kind will eventually use both
vfsmount and dentry, so generally such replacements are *not* a good thing.

