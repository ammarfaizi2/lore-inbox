Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUBGCR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 21:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266516AbUBGCR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 21:17:57 -0500
Received: from mail.shareable.org ([81.29.64.88]:25040 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265547AbUBGCR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 21:17:56 -0500
Date: Sat, 7 Feb 2004 02:17:51 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Valdis.Kletnieks@vt.edu, the grugq <grugq@hcunix.net>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040207021751.GH12503@mail.shareable.org>
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40243C24.8080309@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> reiser4 probably does not need secure deletion as much as others, 
> because once the encryption plugins are debugged we will most likely 
> encourage users to use encryption by default.  Perhaps someone will show 
> the error in my thinking though, I am not trying to be rigid here....

With encrypted block devices, there is the possibility that someone
may discover your key, or gain access to your computer (e.g. steal
your laptop while it's switched on, or someone puts a gun to your head
and makes you enter the key).

If someone gets access you might be glad you securely deleted some
files by overwriting the blocks.

When encryption is implemented in the filesystem itself, this is
preventable.

There is a cryptographic way to ensure deleted files cannot be
recovered even when someone knows the filesystem key, without needing
to overwrite the files.  This is even better than overwriting, because
it resists signal processing methods on the hard disk platter, and is
effective with virtual devices where overwriting does not actually
erase the original data (e.g. VMware or Bochs copy-on-write disk
image; LVM snapshots; some SAN devices).

Thanks in advance for the implementation :)

-- Jamie
