Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266856AbUBGLtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266859AbUBGLtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:49:09 -0500
Received: from www.trustcorps.com ([213.165.226.2]:59653 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266856AbUBGLtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:49:03 -0500
Message-ID: <4024D019.2080402@hcunix.net>
Date: Sat, 07 Feb 2004 11:46:33 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <4024C5DF.40609@hcunix.net> <20040207110912.GB16093@mail.shareable.org>
In-Reply-To: <20040207110912.GB16093@mail.shareable.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> What do you mean?
> 
> I haven't mentioned randomising block allocations at all.
> 
> The random number is an encryption key, private to the inode, used to
> encrypt the data blocks.  The blocks are allocated efficiently as usual.
> 

I didn't understand your proposal. nm.

As I now understand, you are proposing a file system which has per file 
encryption where the key is stored in the inode. The inode is then the 
only location with senstive data which needs to be removed.

What about directory files? That is, how would you propose handling the 
directory entries of deleted files?

Also, this proposal seems to me more related to how to implement an 
encrypted file system, than how to implement secure deletion on existing 
file systems.

> 
> My suggestion would be much more efficient than yours: for every file
> created and deleted, you do twice the I/O I do.

Sorry, per file encryption is more efficient than deffered block writes 
after deletion? What you are proposing is unrelated to secure deletion. 
Its an encrypted file system implementation. Comparing efficiency 
between secure deletion on ext2, for example, and encrypted files on 
some unimplemented file system doesn't make sense.

Now, given that my comments were on what I thought you were proposing 
(randomly allocating inodes and blocks to prevent an analyst being able 
to piece a file back toghether via guess work) not what you actually 
were proposing (an encrypted file system implementation), ignore the 
previous email.


peace,

--gq
