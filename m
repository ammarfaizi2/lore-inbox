Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281578AbRKVT7M>; Thu, 22 Nov 2001 14:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281591AbRKVT7C>; Thu, 22 Nov 2001 14:59:02 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:17662 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281578AbRKVT6w>;
	Thu, 22 Nov 2001 14:58:52 -0500
Date: Thu, 22 Nov 2001 12:57:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
Cc: Tyler BIRD <birdty@uvsc.edu>, linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
Message-ID: <20011122125759.K1308@lynx.no>
Mail-Followup-To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
	Tyler BIRD <birdty@uvsc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <sbfce764.052@MAIL-SMTP.uvsc.edu> <001501c1738b$2a4be5b0$1300a8c0@marcelo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <001501c1738b$2a4be5b0$1300a8c0@marcelo>; from marcelo@datacom-telematica.com.br on Thu, Nov 22, 2001 at 05:23:13PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2001  17:23 -0200, Marcelo Borges Ribeiro wrote:
> This limit is a kernel´s limit not a file system´s limit. Even vfat has a
> limitation of 2GB under linux. I thought with kernel 2.4.x this will be
> over.

Totally incorrect.  2.4 allows files larger than 2GB, and with a patch,
you can do this on 2.2 as well.  If you are having problems with a 2GB
limit, then either your shell, libc, or tools is causing the problem.

VFAT does have a 2GB limit, AFAIK, but I could be wrong.

> ----- Original Message -----
> From: "Tyler BIRD" <birdty@uvsc.edu>
> > Ext2 Filesystems I believe have the limit of 2 GB.  Ext3 Extends that
> > Limit to something??

No, the ext2 and ext3 limits are exactly the same, about 4TB right
now, but they would be larger with a bit of bug fixing (up to 16TB).
Note that the kernel has a limit of 2TB for a single device.

> >     is maximum file size on SMBFS really 2GB? I cannot create file
> > bigger than that.

As for SMBFS, I don't know, but it can obviously not be larger than the
limit on the server.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

