Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268765AbRHKTRC>; Sat, 11 Aug 2001 15:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268792AbRHKTQw>; Sat, 11 Aug 2001 15:16:52 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:32007 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268765AbRHKTQm>; Sat, 11 Aug 2001 15:16:42 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Writes to mounted devices containing file-systems.
Date: 11 Aug 2001 12:16:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9l40a7$9ja$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com> <20010811144729.B31614@wyvern>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010811144729.B31614@wyvern>
By author:    Adrian Bridgett <adrian.bridgett@iname.com>
In newsgroup: linux.dev.kernel
> 
> Personally I'd prefer AIX's approach - let the write through (if the user
> wants to shoot themselves in the foot...), but report an error about it (to
> syslog). 
> 

I don't see any point in having "you just fscked yourself" written to
the syslog.  At the same time, writing to a mounted device is actually
useful: it's currently the only way to write the boot block on an
ext2 filesystem (and Viro: if you start using the page cache for the
superblock in ext2, you probably have to add an explicit interface to
write the boot block at the same time!!!)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
