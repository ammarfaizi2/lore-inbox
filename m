Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133112AbRAGCFG>; Sat, 6 Jan 2001 21:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133117AbRAGCE5>; Sat, 6 Jan 2001 21:04:57 -0500
Received: from losser.st-lab.cs.uu.nl ([131.211.83.40]:42251 "EHLO
	losser.st-lab.cs.uu.nl") by vger.kernel.org with ESMTP
	id <S133112AbRAGCEo> convert rfc822-to-8bit; Sat, 6 Jan 2001 21:04:44 -0500
Date: Sun, 7 Jan 2001 03:07:02 +0100 (CET)
From: Eelco Dolstra <eelco@losser.st-lab.cs.uu.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ivan Baldo <lubaldo@adinet.com.uy>, flf@operamail.com, ben@imben.com,
        linux-kernel@vger.kernel.org, Linux Uruguay <linux-uy@linux.org.uy>,
        SET <salvador@inti.gov.ar>
Subject: Re: How to make VFAT work right in 2.4.0-prereleaseu
In-Reply-To: <E14EzPU-0001SG-00@the-village.bc.nu>
Message-ID: <Pine.BSF.4.21.0101070300030.12461-100000@losser.st-lab.cs.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 6 Jan 2001, Alan Cox wrote:

> > 	- edit file fs/fat/inode.c, look in the function named
> > "fat_notify_change" (at about line 901), where it says:"
> > 	/* FAT cannot truncate to a longer file */
> > 	if (attr->ia_valid & ATTR_SIZE) {
> > 		if (attr->ia_size > inode->i_size)
> > 			return -EPERM;
> > 	}
> > 	", just delete all of it (or comment it out). This change wich has been
> > made in the -prerelease versión, makes Netscape Messenger not to work
> 
> If you do that you will corrupt your FAT fs.

But only on SMP, right?  The only other FAT change I see in -ac (apart
from my patch) is the spinlock around fat_cache.

Regards,

Eelco.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
