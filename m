Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136583AbREEBLA>; Fri, 4 May 2001 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136584AbREEBKu>; Fri, 4 May 2001 21:10:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6162 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136583AbREEBKh>; Fri, 4 May 2001 21:10:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Compressed iso9660 filesystem
Date: 4 May 2001 18:10:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9cvjtr$jku$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I think I now feel comfortable enough that I think I can unleash
this on the world...

I have made an extension to iso9660/RockRidge to allow for transparent
uncompression of block-compressed files.  Because the files are
block-compressed, random access is fast; it uses a 32K blocksize which
gets pretty good compression ratios (I got 2:1 overall compression on
my SuperRescue CD; that includes a fair number of incompressible
files.)

The patches are available as:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/filemap-2.4.4-1.diff.gz
ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/zisofs-2.4.5-pre1-5.diff.gz

(Both are needed.)

Additionally, the user-space utilities (a program to compress and
uncompress file trees, and a patch to mkisofs to generate the new
RockRidge records for compressed files) are available at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/zisofs/

If you test this out, please let me know; I'd like to know if anyone
actually cares about this... also, I would like to gauge if I have
messed up stability anywhere.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
