Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbSKXGdZ>; Sun, 24 Nov 2002 01:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbSKXGdZ>; Sun, 24 Nov 2002 01:33:25 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:53006 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267174AbSKXGdY>;
	Sun, 24 Nov 2002 01:33:24 -0500
Date: Sun, 24 Nov 2002 01:40:34 -0500 (EST)
Message-Id: <200211240640.gAO6eY153080@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: khc@pm.waw.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Halasa writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> Forget the shred program. It's less useful than having the
>> filesystem simply zero the blocks, because it's slow and you
>> can't be sure to hit the OS-visible blocks. Aside from encryption,
>> the useful options are:
>>
>> 1. plain old rm  (protect from users)
>> 2. filesystem clears the blocks  (protect from root/kernel)
>
> It won't protect you from the root.

Sure it will. Like this:

1. you're a user, possibly root, on your own machine
2. you zero the disk blocks of a file
3. somebody cracks root
4. they look for the file -- not there
5. they read /dev/hda to find the data -- not there
6. they modify the kernel -- nope, data still not there

As long as nobody physically opens the drive, it would take some
seriously bad luck involving bad sectors to make your data at all
vulnerable... to somebody with drive manufacturer trade secrets.
If this worries you, destroy the drive and/or make an appointment
with your mental health professional.

Nothing counts if root is already malicious, so that issue
wasn't being addressed. You'd have keyboard snooping,
encryption tools that save a copy, man-in-the middle attacks
on everything... forget it. It's not worth discussing.
