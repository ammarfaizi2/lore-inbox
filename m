Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUIYRlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUIYRlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269371AbUIYRlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:41:20 -0400
Received: from [203.178.140.15] ([203.178.140.15]:6668 "EHLO yue.st-paulia.net")
	by vger.kernel.org with ESMTP id S269370AbUIYRlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:41:18 -0400
Date: Sun, 26 Sep 2004 02:41:31 +0900 (JST)
Message-Id: <20040926.024131.06508879.yoshfuji@linux-ipv6.org>
To: jra@samba.org
Cc: torvalds@osdl.org, samuel.thibault@ens-lyon.org,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [2.6] smbfs & "du" illness
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040925171104.GN580@jeremy1>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
	<Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org>
	<20040925171104.GN580@jeremy1>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20040925171104.GN580@jeremy1> (at Sat, 25 Sep 2004 10:11:04 -0700), Jeremy Allison <jra@samba.org> says:

> > And yes, that's a _fixed_ blocksize. When you use "stat()", and you look 
> > at "st_blocks", it's ALWAYS in 512-byte entities. It doesn't matter that 
> > "st_blksize" might be something else - when UNIX counts blocks, it counts 
> > them in 512-byte chunks.
> 
> st_blocks and st_blksize are not in the POSIX spec
:
> That's why I got so pissed with the extensions spec
> as it didn't specify a unit size. Rather an assume
> "all the world is 512" which is plainly wrong, I
> decided to make it a unit of bytes on the wire.
> The client can then return in the correct blocksize
> for it's own system.

http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html#tag_13_62

|The unit for the st_blocks member of the stat structure is not 
|defined within IEEE Std 1003.1-2001. In some implementations it 
|is 512 bytes. It may differ on a file system basis. There is no 
|correlation between values of the st_blocks and st_blksize, and 
|the f_bsize (from <sys/statvfs.h>) structure members.

--yoshfuji
