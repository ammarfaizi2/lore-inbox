Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSKVCeL>; Thu, 21 Nov 2002 21:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSKVCeL>; Thu, 21 Nov 2002 21:34:11 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:1299 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265059AbSKVCeJ>;
	Thu, 21 Nov 2002 21:34:09 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200211220241.gAM2fEZ357378@saturn.cs.uml.edu>
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
To: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 21 Nov 2002 21:41:14 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
       kentborg@borg.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <3DDD88BB.209@pobox.com> from "Jeff Garzik" at Nov 21, 2002 08:30:35 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Albert D. Cahalan wrote:

>> Forget the shred program. It's less useful than having the
>> filesystem simply zero the blocks, because it's slow and you
>> can't be sure to hit the OS-visible blocks.
>
> Why not?
>
> Please name a filesystem that moves allocated blocks around on you.  And 
> point to code, too.

Reiserfs tails
  fs/reiserfs

ext3 with data journalling
  fs/ext3

the journalling flash filesystems
  fs/jffs
  fs/jffs2

NTFS with compression
  fs/ntfs


Some of these are listed in the shred man page.

Multiple overwrites won't protect you from the disk manufacturer
or the NSA. Only one is needed to protect against root & kernel.
So it makes sense to have the filesystem zero the blocks when
they are freed from a file.
