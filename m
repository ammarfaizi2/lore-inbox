Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315206AbSEDWEg>; Sat, 4 May 2002 18:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315208AbSEDWEf>; Sat, 4 May 2002 18:04:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6419 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315206AbSEDWEe>; Sat, 4 May 2002 18:04:34 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initramfs
Date: 4 May 2002 15:04:12 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ab1lss$2fi$1@cesium.transmeta.com>
In-Reply-To: <1744hw-0EYlYuC@fwd01.sul.t-online.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1744hw-0EYlYuC@fwd01.sul.t-online.com>
By author:    "ChristianK."@t-online.de (Christian Koenig)
In newsgroup: linux.dev.kernel
> 
> I have tried to implement the "initramfs buffer spec -- third draft" by hpa 
> and Al Viro. 
> 
> It isn't complete yet, because off the following unresolved topics:
> 1. For the moment it only supports files,dirs and symlinks.
> 2. It still needs the "RAM disk" and "initrd" support compiled in the Kernel.
> 3. I haven't tried to support hardlinks.
> 4. Since i use the ramdisk for decompression the cpio image must be a 
> multiple of BLOCK_SIZE bytes.
> 5. The cpio crc field is ignored.
> 
> I have done this only for testing if the "initramfs buffer spec -- third 
> draft" suffers all requirements. And to give a starting point for 
> implementing this. The patch works for linux 2.5.9 - 2.5.13.
> 
> The only problem i found is that after a "TRAILER!!!" cpio (per default) 
> align on a 512 bytes boundary, not 4 bytes.

This is consistent with the spec.  It isn't *required* by the spec,
but a data generator is free to add arbitrary amounts of zero-padding.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
