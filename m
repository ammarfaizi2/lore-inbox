Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145383AbRA2GmZ>; Mon, 29 Jan 2001 01:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S159751AbRA2GmP>; Mon, 29 Jan 2001 01:42:15 -0500
Received: from www.wen-online.de ([212.223.88.39]:3085 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S145383AbRA2GmG>;
	Mon, 29 Jan 2001 01:42:06 -0500
Date: Mon, 29 Jan 2001 07:41:49 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Mo McKinlay <mmckinlay@gnu.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
In-Reply-To: <Pine.LNX.4.30.0101282140210.17985-100000@nvws005.nv.london>
Message-ID: <Pine.Linu.4.10.10101290724260.1972-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Mo McKinlay wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Today, H. Peter Anvin (hpa@zytor.com) wrote:
> 
>   > Hello people... the original question was: can lost+found be
>   > *renamed*, i.e. does the tools (e2fsck &c) use "/lost+found" by name,
>   > or by inode?  As far as I know it always uses the same inode number
>   > (11), but I don't know if that is anywhere enforced.
> 
> I seem to recall e2fsck complaining when I renamed lost+found, but that
> may well be a consistency check. Don't quote me on this, though.

(pretty easy to find out:)

[root]:# fsck -f /test
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
/lost+found not found.  Create<y>?

It created lost+found with inode 183 as 11 was used by renamed dir.
No idea if it would have trouble salvaging a corrupt fs after this.
(but logic says no it dare not)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
