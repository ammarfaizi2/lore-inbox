Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283038AbRK1Nqm>; Wed, 28 Nov 2001 08:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283040AbRK1Nqb>; Wed, 28 Nov 2001 08:46:31 -0500
Received: from [195.66.192.167] ([195.66.192.167]:36614 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S283038AbRK1NqQ>; Wed, 28 Nov 2001 08:46:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [BUG] 2.4.16pre1: minix initrd does not work, ext2 does
Date: Wed, 28 Nov 2001 15:41:51 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011127151356.ast@domdv.de> <01112812184503.00924@manta>
In-Reply-To: <01112812184503.00924@manta>
MIME-Version: 1.0
Message-Id: <01112815415100.00898@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 November 2001 12:18, vda wrote:
> ext2.gz contains gzipped ext2 ramdisk image.
> minix.gz contains gzipped minix ramdisk image.
> minix is gunzipped minix.gz.
>
> Initrd          2.4.10  2.4.13,2.4.16pre1
> --------------- ------- -----------------
> ext2.gz         ok      ok
> minix.gz        ok      minix fs not detected (bad fs magic)
> minix           ok      minix magic ok, can't open console, can't find init
>
> (2.4.16pre1 was instrumented to show minix magic etc)
>
> As you can see, we have decompression bug: results for
> compressed and uncompressed minix ramdisks are different.
> Or maybe kernel corrupts ramdisk image after gunzip.
> I'm puzzled...
>
> Guys, who fiddled with zlib/ramdisk/??? in 2.4.11 - 2.4.13 range?

I narrowed it down to 2.4.10 -> 2.4.12 (2.4.11-dontuse wasn't tested)
2.4.10 can boot my minix initrd, 2.4.12 can't.
--
vda
