Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292602AbSBUAXg>; Wed, 20 Feb 2002 19:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292598AbSBUAX1>; Wed, 20 Feb 2002 19:23:27 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:59893 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292599AbSBUAXV>;
	Wed, 20 Feb 2002 19:23:21 -0500
Date: Wed, 20 Feb 2002 17:23:12 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Kallol Biswas <kallol@efi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lseek SEEK_END fails on a Toshiba 6007MB disk.
Message-ID: <20020220172312.I1506@lynx.adilger.int>
Mail-Followup-To: Kallol Biswas <kallol@efi.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C7433F8.8FB86B39@efi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7433F8.8FB86B39@efi.com>; from kallol@efi.com on Wed, Feb 20, 2002 at 03:40:40PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 20, 2002  15:40 -0800, Kallol Biswas wrote:
> offset = lseek(fd, 0, SEEK_END);
> 
> lseek: Value too large for defined data type

You need to use a 64-bit lseek (e.g. llseek or lseek64).  This can
be done with '#define _LARGEFILE_SOURCE' and/or '#define _LARGEFILE64_SOURCE'
and/or '#define _FILE_OFFSET_BITS=64'.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

