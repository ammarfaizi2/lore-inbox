Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277372AbRJJVNw>; Wed, 10 Oct 2001 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277114AbRJJVNp>; Wed, 10 Oct 2001 17:13:45 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27119 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277005AbRJJVNi>; Wed, 10 Oct 2001 17:13:38 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 10 Oct 2001 15:13:33 -0600
To: Andris Pavenis <pavenis@latnet.lv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11: mount flag noexec still broken for VFAT partition
Message-ID: <20011010151333.G10443@turbolinux.com>
Mail-Followup-To: Andris Pavenis <pavenis@latnet.lv>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110102258290.28429-100000@gulbis.latnet.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110102258290.28429-100000@gulbis.latnet.lv>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 10, 2001  23:01 +0300, Andris Pavenis wrote:
> Similary as with 2.4.10 mount flag noexec does not work for VFAT
> partition. I have following in fstab
> 
> /dev/hda1      /c       vfat     noexec,gid=201,umask=002,quiet  1    0
> /dev/hda5      /d       vfat     noexec,gid=201,umask=002,quiet  1    0
> 
> but I see that all files in corresponding filesystems are still 
> exectuable

Probably because your uid or gid match the above, so your access permission
is done by checking "user" or "group" and not "other".  Try "umask=113"
instead.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

