Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130486AbQK2Nfy>; Wed, 29 Nov 2000 08:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131056AbQK2Nfo>; Wed, 29 Nov 2000 08:35:44 -0500
Received: from 213-123-77-81.btconnect.com ([213.123.77.81]:20740 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130486AbQK2Nfc>;
        Wed, 29 Nov 2000 08:35:32 -0500
Date: Wed, 29 Nov 2000 13:07:01 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Adam <adam@cfar.umd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <Pine.GSO.4.21.0011290755570.2862-100000@chia.umiacs.umd.edu>
Message-ID: <Pine.LNX.4.21.0011291306260.883-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Adam wrote:
> However, when I try on 'development' 2.4.x kernel
> 
> 	[adam@pepsi /tmp]$ uname -a
> 	Linux pepsi 2.4.0-test7-packet #24 SMP Fri Sep 8 20:26:35 EDT 2000 i686
> 
> 	[adam@pepsi /tmp]$  dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> 	1000+0 records in
> 	1000+0 records out
> 
> 	[adam@pepsi /tmp]$ ls -l holed.file 
> 	-rw-rw-r--    1 adam     adam      6000000 Nov 29 08:52 holed.file
> 
> 	[adam@pepsi /tmp]$ du -sh holed.file 
> 	1.9M    holed.file
> 

what filesystem type? on ext2 filesystem on 2.4.0-test12-pre3 I get
expected result:

# dd if=/dev/zero of=hole bs=1000 seek=5000 count=1000
1000+0 records in
1000+0 records out
# l hole
-rw-r--r--    1 root     root      6000000 Nov 29 13:06 hole
# du -sh hole
988k    hole
# u
Linux penguin 2.4.0-test12 #1 Wed Nov 29 09:08:13 GMT 2000 i686 unknown

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
