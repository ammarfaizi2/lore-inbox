Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbREWM3z>; Wed, 23 May 2001 08:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263071AbREWM3p>; Wed, 23 May 2001 08:29:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7371 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263070AbREWM3l>;
	Wed, 23 May 2001 08:29:41 -0400
Date: Wed, 23 May 2001 14:29:05 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105231229.OAA19155.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] struct char_device
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From alan@lxorguk.ukuu.org.uk Wed May 23 14:16:46 2001

    > It is entirely possible to remove all partition table handling code
    > from the kernel. User space can figure out where the partitions
    > are supposed to be and tell the kernel.
    > For the initial boot this user space can be in an initrd,
    > or it could just be a boot parameter: rootdev=/dev/hda,
    > rootpartition:offset=N,length=L, rootfstype=ext3.

    Not if you want compatibility.

I don't think compatibility is a problem.
It would go like this: at configure time you get the
choice of the default initrd or a custom initrd.
If you choose the custom one you construct it yourself.
If you choose the default one, then you get something
that comes together with the kernel image, just like
the piggyback stuff today. This default initrd does
the partition parsing that up to now the kernel did.
That way nobody need to notice a difference, except for
those who use initrd already now. They can solve their
problems.

Andries


