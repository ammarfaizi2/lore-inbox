Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRK0MkW>; Tue, 27 Nov 2001 07:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRK0MkM>; Tue, 27 Nov 2001 07:40:12 -0500
Received: from goliath.siemens.de ([194.138.37.131]:30950 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S277568AbRK0Mjv>; Tue, 27 Nov 2001 07:39:51 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'Paul Bristow'" <paul@paulbristow.net>
Cc: rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: RE: ide-floppy.c vs devfs
Date: Tue, 27 Nov 2001 15:34:23 +0300
Message-ID: <000601c1773f$d80d9ba0$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <3C027F7A.1070406@paulbristow.net>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> This is made somewhat more complicated by the fact that ide-floppy
disks
> can use either the whole disk, with no partition table or, more
> commonly, partition4.  So a user-friendly solution would be to create
a
> floppy node that pointed to the partition, if it existed, or the whole
> disk if it didn't.  With appropriate code to handle that fact that
> anyone can partition these disks in any way they like.
> 

Where's the problem? Use .../disc for whole disc or .../part4 for
"normal" access. (Or /dev/hdc and /dev/hdc4 if you prefer) It is nice if
partition code can detect it but it is not ide-floppy driver problem.

> Note this doesn't take account of the nice ATAPI command that sets the
> disk into "ignore track 0" mode, making a partition 4 look like an
> entire floppy with 1 less track.
> 

Why complicate things more than needed?

> Anyone up to telling me how this is handled in the SCSI layer?
> 

When I boot without media in Jaz drive I get something like "no media
inserted, assuming 1GB 512B per sector". Actually I modeled my patch
from this - use some default values reported by drive when no media
currently exists.

-andrej
