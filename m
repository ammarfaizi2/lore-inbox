Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262132AbREPXYc>; Wed, 16 May 2001 19:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbREPXYW>; Wed, 16 May 2001 19:24:22 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30980 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262132AbREPXYL>; Wed, 16 May 2001 19:24:11 -0400
Message-ID: <3B030C11.3270CFA7@transmeta.com>
Date: Wed, 16 May 2001 16:24:01 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.GSO.4.21.0105161850200.26191-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> In full variant of patch I don't _have_ mount_root(9). It's done by
> mount(2). Period. Initrd or not. Notice that rootfs stays absolute root
> forever - it's much more convenient for fs/super.c, since you can get rid
> of many kludges that way. So I'm not too happy about populating rootfs with
> tons of files. BTW, loading initrd is done by open(2), read(2) and write(2) -
> none of this fake struct file business anymore.
> 

OK, I see what you're doing now.  However, I'm confused what you mean
with "rootfs stays absolute root forever" -- does that mean that you
mount the new root on top of /, and so the rootfs remains in the system
never to be reclaimed, as opposed to pivot_root-ing it?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
