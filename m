Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbQLWH5S>; Sat, 23 Dec 2000 02:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbQLWH5H>; Sat, 23 Dec 2000 02:57:07 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:30702 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S130187AbQLWH4w>; Sat, 23 Dec 2000 02:56:52 -0500
Date: Sat, 23 Dec 2000 18:26:27 +1100
From: CaT <cat@zip.com.au>
To: Damacus Porteng <kernel@bastion.yi.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Arg.  File > 2GB removal
Message-ID: <20001223182627.B344@zip.com.au>
In-Reply-To: <20001223021615.A8201@bastion.sprileet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001223021615.A8201@bastion.sprileet.net>; from kernel@bastion.yi.org on Sat, Dec 23, 2000 at 02:16:15AM -0600
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 02:16:15AM -0600, Damacus Porteng wrote:
> For grins, I did `dd if=/dev/zero of=testfile bs=1024 count=4000000` 
> 
> Obviously, with the limits of ext2, this isn't allowed, however, dd continued
> marrily on its way, tho it spouted an error...
> 
> I cancelled the dd and went to remove the file, though the following occured:
> root@obfuscated:/home/ftp# rm testfile
> rm: cannot remove `testfile': Value too large for defined data type     

Hrm... This is with 2.2.18:

[18:17:15] hogarth@theirongiant:/data>> dd if=/dev/zero of=testfile bs=1024 count=4000000
dd: testfile: File too large
2097152+0 records in
2097151+0 records out
[18:21:07] hogarth@theirongiant:/data>> rm testfile
[18:24:16] hogarth@theirongiant:/data>> 

So it worked for me... Regardless though have you tried

>testfile
rm testfile

?

-- 
CaT (cat@zip.com.au)

	'We do more then just sing and dance. We've got a brain too.'
		-- The Backstreet Boys
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
