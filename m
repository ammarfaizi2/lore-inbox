Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284491AbRLEQ5O>; Wed, 5 Dec 2001 11:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284494AbRLEQ5E>; Wed, 5 Dec 2001 11:57:04 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:26521 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S284493AbRLEQ4q>; Wed, 5 Dec 2001 11:56:46 -0500
Date: Wed, 5 Dec 2001 16:56:43 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
cc: <linuxlist@visto.com>, <linux-kernel@vger.kernel.org>
Subject: Re: newly compiled kernel no .img file
In-Reply-To: <3C0E4E1A.9A6D5E64@didntduck.org>
Message-ID: <Pine.LNX.4.33.0112051651030.5995-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:40 -0500 Brian Gerst wrote:

>> If you notice the first declaration of image the >
>> "initrd=/boot/initrd-2.4.7-10.img" is not present . Of course I removed
>> it so that there would be no kernel panic and I am able to boot into the
>> new kernel (xunil). > What I want to know is what is this .img file why
>> is it required in the original kernel compilation and not in the newer .
>
>Your distribution put that there so that it can use modules for drivers
>that are required to mount the root filesystem (ie. SCSI, fs driver,
>etc.).  If you build your own kernel, those drivers should be built
>non-modular, therefore you won't need an initrd.

Yes for most users.

I'd like to build a quite generic 2.4 tree with everything as a module
where possible. I am forced to compile in binfmt_elf, initrd and romfs.

This allows me to use one tree for several different machines (some might
have an ext3 / on an IDE HDD; others maybe reiserfs on a gdth controller
etc..) without a huge amount of dead code in the kernel. So.. when a
subset of them are buggy we can see what modules they have in common..

My question: is this mega-module setup likely to be less stable than a
monolith? I'm not fussed about a % or two performance loss.

Matt

