Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSHMFY6>; Tue, 13 Aug 2002 01:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318934AbSHMFY6>; Tue, 13 Aug 2002 01:24:58 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:59896 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317380AbSHMFY5>; Tue, 13 Aug 2002 01:24:57 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 12 Aug 2002 23:25:59 -0600
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020813052559.GC9642@clusterfs.com>
Mail-Followup-To: Adam Kropelin <akropel1@rochester.rr.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au> <20020813022550.GA6810@www.kroptech.com> <3D587706.A0F2DC21@zip.com.au> <20020813041011.GA12227@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813041011.GA12227@www.kroptech.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2002  00:10 -0400, Adam Kropelin wrote:
> On Mon, Aug 12, 2002 at 08:03:34PM -0700, Andrew Morton wrote:
> > Are you _sure_ it was bad with ext2?
> 
> Yes.
> 
> [root@devbox adk0212] mount
> /dev/hda3 on / type ext2 (rw)
> /dev/hda1 on /boot type ext2 (rw)
> 
> Is it possible that the darn thing is mounted ext3 even though fstab and mount
> agree that it's ext2?

Yes, if you have a journal on your root filesystem, then it will be mounted
as ext3 regardless of what it says in /etc/fstab.  Since "mount" also
looks in /etc/fstab for writing the entry in /etc/mtab _after_ the root
filesystem is mounted, the output from "mount" can also be bogus.  You
need to check /proc/mounts to see the real answer.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

