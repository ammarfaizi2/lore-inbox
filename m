Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275709AbRIZX44>; Wed, 26 Sep 2001 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275711AbRIZX4r>; Wed, 26 Sep 2001 19:56:47 -0400
Received: from earth.ayrnetworks.com ([64.166.72.139]:39435 "EHLO
	earth.ayrnetworks.com") by vger.kernel.org with ESMTP
	id <S275709AbRIZX4o>; Wed, 26 Sep 2001 19:56:44 -0400
Date: Wed, 26 Sep 2001 16:55:24 -0700 (PDT)
From: Brad <prettygood@cs.stanford.edu>
X-X-Sender: <bradb@earth.ayrnetworks.com>
Reply-To: <prettygood@cs.stanford.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Cramfs Endianness
Message-ID: <Pine.LNX.4.33.0109261640310.19715-100000@earth.ayrnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although the documentation states that always going with little endian is
the easiest solution and what was "decided" on, neither the kernel nor
mkcramfs swabs on a big endian machine.  This is decidedly a problem with
what we're doing, so I wrote a patch to swab the easy and not-quite-so-easy
bitfields such that mkcramfs writes little endian images and the kernel
swabs (if byteorder is defined as big_endian or __MIPSEB__ is defined)..
It looks at the magic to determine whether to swab or not.

We've needed this, so we will have to incorporate this into a parallel
repository if not added to the kernel.  Is there another solution afoot,
or might I submit this patch? (please cc me if you respond)

Thanks,
Brad


