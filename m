Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265546AbSKABLa>; Thu, 31 Oct 2002 20:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265547AbSKABLa>; Thu, 31 Oct 2002 20:11:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:13564 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265546AbSKABL2>;
	Thu, 31 Oct 2002 20:11:28 -0500
Message-ID: <3DC1D63A.CCAD78EF@digeo.com>
Date: Thu, 31 Oct 2002 17:17:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2002 01:17:46.0782 (UTC) FILETIME=[7C96EBE0:01C28144]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> Green and Zam and Umka, on Monday please start work on seriously
> analyzing how the block allocation differs between the new and the old
> kernel, now that you can finally reproduce the benchmark on the old kernel.

I just sent the Orlov allocator patch to Linus.  It will double or
triple ext2 performance in that test, so please make sure you compare
against the latest.  There's a copy at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.45/shpte-stuff/broken-out/orlov-allocator.patch

We can expect similar gains for ext3, when that's done.

(The 2x-3x is on an 8meg filesystem.  Larger filesystems should
gain more)
