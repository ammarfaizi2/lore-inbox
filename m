Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbREPWVr>; Wed, 16 May 2001 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbREPWVh>; Wed, 16 May 2001 18:21:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32273 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262109AbREPWVa>; Wed, 16 May 2001 18:21:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] rootfs (part 1)
Date: 16 May 2001 15:21:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9duuh1$mes$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105161010200.4738-100000@penguin.transmeta.com> <Pine.GSO.4.21.0105161434420.26191-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0105161434420.26191-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> Well, since all I actually use in the full variant of patch is sys_mknod(),
> sys_chdir() and sys_mkdir()... IMO tmpfs is an overkill here. Maybe we
> really need minimal rootfs in the kernel (no regular files) and let
> ramfs, tmpfs, whatever-device-fs use it as a library.
> 

One thing that I thought was really spiffy was someone who had done
patches to populate a ramfs from a tarball loaded via the initrd
bootloader protocol... call it "initial ramfs."  It allowed a whole
lot of cleanup -- the "initrd" isn't magic anymore (instead use
pivot_root), and it gets rid of the rd stuff.  At the same time it
does allow the full flexibility of a fullblown filesystem that can be
populated with arbitrary contents.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
