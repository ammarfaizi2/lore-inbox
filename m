Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263053AbREWL6V>; Wed, 23 May 2001 07:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263057AbREWL6L>; Wed, 23 May 2001 07:58:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12474 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263053AbREWL6H>;
	Wed, 23 May 2001 07:58:07 -0400
Date: Wed, 23 May 2001 13:57:20 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105231157.NAA80659.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: [PATCH] struct char_device
Cc: Andries.Brouwer@cwi.nl, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes:

    The current partitioning code consists of re-reading from disk. That is 
    code that has to be present anyway even without an initrd since it is
    needed for mounting other filesystems

I am not quite sure what you are saying here.
(For example, the "even" was unexpected.)

It is entirely possible to remove all partition table handling code
from the kernel. User space can figure out where the partitions
are supposed to be and tell the kernel.
For the initial boot this user space can be in an initrd,
or it could just be a boot parameter: rootdev=/dev/hda,
rootpartition:offset=N,length=L, rootfstype=ext3.

mount does not need any partition reading code.

Andries


[I conjecture that we'll want to start moving partition parsing
out into userspace fairly soon. Indeed, soon we'll see EFI everywhere,
and there is no good reason to build knowledge about that into the kernel.]
