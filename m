Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTDECBb (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 21:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbTDEB7U (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:59:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54751 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261755AbTDEB5r (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:57:47 -0500
Date: Fri, 04 Apr 2003 17:59:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Error whilst running "tune2fs -j"
Message-ID: <5750000.1049507953@flay>
In-Reply-To: <20030404155633.29ed6f8a.akpm@digeo.com>
References: <5880000.1049498738@flay> <20030404155633.29ed6f8a.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Anyone see this before? This was 2.5.65-mjb2 running on my laptop,
>> at the start of a "tune2fs -j" ....
>> 
>> buffer layer error at fs/buffer.c:395
> 
> grrr.  This means that the block_dev layer somehow managed to get the
> filesystem softblocksize confused.  There is something lurking in there.  As
> usual, if I could reproduce it I could fix it.
> 
> Was the fs mounted at the time?

Yes, was my root fs.
 
> What version of e2fsprogs?

Standard debian woody:

mbligh@flay:~/tmp$ apt-cache show e2fsprogs
Package: e2fsprogs
Essential: yes
Priority: required
Section: base
Installed-Size: 832
Maintainer: Yann Dirson <dirson@debian.org>
Architecture: i386
Version: 1.27-2
Provides: libcomerr2, libss2, libext2fs2, libe2p2, libuuid1
Pre-Depends: libc6 (>= 2.2.4-4)
Suggests: gpart, parted, e2fsck-static
Conflicts: e2fslibsg, dump (<< 0.4b4-4), quota (<< 1.55-8.1)
Filename: pool/main/e/e2fsprogs/e2fsprogs_1.27-2_i386.deb
Size: 335402

> Can you reproduce it?

Not easily, I fear ... since it's a pain in the butt to remove an ext3
journal on the root fs once mounted. I suppose I could boot from CD
or something ... will try to recreate on a less valuable box over
the weekend ;-)

I had been having some other trouble with the fs (power cycled a couple
of times for silly reasons), but it had just ext2 fscked. I suppose there
*might* have been some corruption, but seems unlikely.

M.

