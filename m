Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136794AbREIRyt>; Wed, 9 May 2001 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136796AbREIRyj>; Wed, 9 May 2001 13:54:39 -0400
Received: from babylon5.babcom.com ([216.36.71.34]:1664 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S136794AbREIRyY>; Wed, 9 May 2001 13:54:24 -0400
Date: Wed, 9 May 2001 10:54:23 -0700
From: Phil Stracchino <alaric@babcom.com>
To: Linux-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: CDROM troubles -- followup
Message-ID: <20010509105423.A725@babylon5.babcom.com>
Mail-Followup-To: Linux-KERNEL <linux-kernel@vger.kernel.org>
In-Reply-To: <20010506030500.A26278@babylon5.babcom.com> <20010506144228.B13711@babylon5.babcom.com> <20010507000116.D506@suse.de> <20010506161701.A778@babylon5.babcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010506161701.A778@babylon5.babcom.com>; from alaric@babcom.com on Sun, May 06, 2001 at 04:17:01PM -0700
X-No-Archive: Yes
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-Copyright: This message may not be reproduced, in part or in whole, for any commercial purpose without prior written permission.  Prior permission for securityfocus.com is implicit.
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  The sending of any UCE to this domain may result in the imposition of civil liability against the sender in accordance with Cal. Bus. & Prof. Code Section 17538.45, and all senders of UCE will be permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 04:17:01PM -0700, Phil Stracchino wrote:
> The patch does indeed seem to prevent the panic, but not the underlying
> problem.  Here's the results of a series of mount/umount operations after
> applying the patch:
> 
> 	*** CD inserted
> VFS: Disk change detected on device sr(11,0)
> 	*** first mount (succeeded)
> ISO 9660 Extensions: RRIP_1991A
> 	*** second mount (succeeded)
> ISO 9660 Extensions: RRIP_1991A
> 	*** third mount (succeeded)
> ISO 9660 Extensions: RRIP_1991A
> 	*** fourth and subsequent mounts failed
> sr: ran out of mem for scatter pad
>  I/O error: dev 0b:00, sector 252
> isofs_read_super: bread failed, dev=0b:00, iso_blknum=63, block=126
> sr: ran out of mem for scatter pad
>  I/O error: dev 0b:00, sector 0
> sr: ran out of mem for scatter pad
>  I/O error: dev 0b:00, sector 64
> sr: ran out of mem for scatter pad
>  I/O error: dev 0b:00, sector 0
> 	*** the last manual mount attempt
> sr: ran out of mem for scatter pad
>  I/O error: dev 0b:00, sector 64


I have just updated to kernel 2.4.4-ac6 and modutils-2.4.6.  While the
sr-scatter patch alone did not fix this problem, after uupgrading to -ac6,
the problem no longer appears to be present.  


-- 
 Linux Now!   ..........Because friends don't let friends use Microsoft.
 phil stracchino   --   the renaissance man   --   mystic zen biker geek
    Vr00m:  2000 Honda CBR929RR   --   Cage:  2000 Dodge Intrepid R/T
 Previous vr00mage:  1986 VF500F (sold), 1991 VFR750F3 (foully murdered)
