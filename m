Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317438AbSFNFqJ>; Fri, 14 Jun 2002 01:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSFNFqI>; Fri, 14 Jun 2002 01:46:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56243 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317438AbSFNFqI>;
	Fri, 14 Jun 2002 01:46:08 -0400
Date: Fri, 14 Jun 2002 07:45:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Jim Nelson <jimnelson@btinet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking CD tray w/o opening device
Message-ID: <20020614054556.GE4779@suse.de>
In-Reply-To: <200206110328.g5B3SgL08447@marc2.theaimsgroup.com> <200206110328.g5B3SgL08447@marc2.theaimsgroup.com> <5.1.0.14.2.20020613150319.00a09360@mail.btinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13 2002, Jim Nelson wrote:
> At 12:00 AM 6/11/02 -0500, you wrote:
> >You could echo "1" >/proc/sys/dev/cdrom/lock
> >
> >If you do this, even when a cd is *not* in the drive it will be locked.
> >For information like this, it might be best to open xchat, and head to
> >openprojects.net and join #linuxhelp. This is a good question, just
> >perhaps  not right for the lkml?
> 
> 
> Um, No.  My /proc/sys/dev/cdrom/lock defaults to a 1, and the drive opens 
> when a disc is not present at the touch of the button. 

Yeah, the above explanation of 'lock' is wrong. It merely controls
whether the tray should be locked when someone is using the CD-ROM. If
noone is using it, it will still be unlocked. There _is_ a var that
controls permanent locking, however it isn't exported through proc.
You'll have to use the CDROM_LOCKDOOR ioctl.

-- 
Jens Axboe

