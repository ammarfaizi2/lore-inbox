Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUBGLJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUBGLJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:09:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:51664 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266815AbUBGLJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:09:16 -0500
Date: Sat, 7 Feb 2004 11:09:12 +0000
From: Jamie Lokier <jamie@shareable.org>
To: the grugq <grugq@hcunix.net>
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040207110912.GB16093@mail.shareable.org>
References: <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <4024C5DF.40609@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4024C5DF.40609@hcunix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the grugq wrote:
> Yes, the allocation of the inode and data blocks should be randomized 
> for security, but that would lead to performance impacts. Implementing 
> that should definately be a compile time option.

What do you mean?

I haven't mentioned randomising block allocations at all.

The random number is an encryption key, private to the inode, used to
encrypt the data blocks.  The blocks are allocated efficiently as usual.

> Your suggestion would certainly work, but I think the performance impact 
> of using random inodes and data blocks would dissuade many from having 
> it enabled by default. Simple secure deletion of the data and meta-data 
> would have a lower impact, and be more likely to be used on more file 
> systems.

My suggestion would be much more efficient than yours: for every file
created and deleted, you do twice the I/O I do.

-- Jamie
