Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbSKVBPU>; Thu, 21 Nov 2002 20:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbSKVBPU>; Thu, 21 Nov 2002 20:15:20 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:19729 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267261AbSKVBPT>;
	Thu, 21 Nov 2002 20:15:19 -0500
Date: Thu, 21 Nov 2002 20:22:26 -0500 (EST)
Message-Id: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: kentborg@borg.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
> On Thu, 2002-11-21 at 19:05, Kent Borg wrote:

>> Another example of why this needs to be done in the file system.  (And
>> that help is sometimes needed from the "disk" particularly in cases
>> like flash IDE rives.)
>
> The file system can't do it
> The flash device won't give you the info to do it
> The ide disk wont give you the info to do it

That's being an idealist. You can protect against everybody
except the NSA and the disk manufacturer. Most likely they'd
need to spend lots of money in a clean room to get your data.

Forget the shred program. It's less useful than having the
filesystem simply zero the blocks, because it's slow and you
can't be sure to hit the OS-visible blocks. Aside from encryption,
the useful options are:

1. plain old rm  (protect from users)
2. filesystem clears the blocks  (protect from root/kernel)
3. physically destroy the disk  (protect from NSA & manufacturer)
