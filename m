Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBVCl7>; Wed, 21 Feb 2001 21:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbRBVCls>; Wed, 21 Feb 2001 21:41:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31493 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129693AbRBVClg>; Wed, 21 Feb 2001 21:41:36 -0500
Message-ID: <3A947C54.E4750E74@transmeta.com>
Date: Wed, 21 Feb 2001 18:41:24 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: Daniel Phillips <phillips@innominate.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Basically (IMHO) we will not really get any noticable benefit with 1 level
> index blocks for a 1k filesystem - my estimates at least are that the break
> even point is about 5k files.  We _should_ be OK with 780k files in a single
> directory for a while.
>

I've had a news server with 2000000 files in one directory.  Such a
filesystem is likely to use small blocks, too, because each file is
generally small.

This is an important connection: filesystems which have lots and lots of
small files will have large directories and small block sizes.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
