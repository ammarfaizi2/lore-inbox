Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290157AbSA3RM5>; Wed, 30 Jan 2002 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSA3RMi>; Wed, 30 Jan 2002 12:12:38 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18955
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290230AbSA3RMR> convert rfc822-to-8bit; Wed, 30 Jan 2002 12:12:17 -0500
Date: Wed, 30 Jan 2002 09:04:17 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Eduardo =?iso-8859-1?Q?Tr=E1pani?= <etrapani@unesco.org.uy>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clipped disk reports clipped lba size
In-Reply-To: <3C580AF6.90EF7086@unesco.org.uy>
Message-ID: <Pine.LNX.4.10.10201300903110.16570-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Eduardo Trápani wrote:

> 
> Since my BIOS does not support my disk (WD400) I had to clip to 33.8G.  At boot time Linux (2.4.17) uses the lba size reported by the disk, that is 33.8 and does not allow me to access the rest of the disk.
> 
> The problem is that even though the whole disk can be used after clipping, Linux uses only the reported lba size even if I force the geometry.
> 
> Here is a patch to solve that.  I am sure there is a more elegant solution, I guess we could add a "lba_size=" or something like that as a boot parameter.
> 
> The patch against 2.4.17 does this:  if the geometry has been forced then use it to calculate the lba size and ignore the (possibly clipped) answer from the disk.
> 
> Eduardo.

Maybe if 2.4 would ever take a patch ... You would have this option at
compile time.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

