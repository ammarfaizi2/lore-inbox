Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSHMRUd>; Tue, 13 Aug 2002 13:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSHMRU3>; Tue, 13 Aug 2002 13:20:29 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:58362 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318219AbSHMRT1>; Tue, 13 Aug 2002 13:19:27 -0400
Date: Tue, 13 Aug 2002 11:21:15 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020813172115.GF9642@clusterfs.com>
Mail-Followup-To: Adam Kropelin <akropel1@rochester.rr.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
References: <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au> <20020813022550.GA6810@www.kroptech.com> <3D587706.A0F2DC21@zip.com.au> <20020813041011.GA12227@www.kroptech.com> <20020813052559.GC9642@clusterfs.com> <20020813123738.GA28603@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813123738.GA28603@www.kroptech.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2002  08:37 -0400, Adam Kropelin wrote:
> On Mon, Aug 12, 2002 at 11:25:59PM -0600, Andreas Dilger wrote:
> > Yes, if you have a journal on your root filesystem, then it will be mounted
> > as ext3 regardless of what it says in /etc/fstab.  Since "mount" also
> > looks in /etc/fstab for writing the entry in /etc/mtab _after_ the root
> > filesystem is mounted, the output from "mount" can also be bogus.  You
> > need to check /proc/mounts to see the real answer.
> 
> Ahhh, carp.
> 
> It's still ext3, precisely as you describe.
> 
> */me hangs head in shame*
> 
> When I get home tonight I'll reboot with a rescue disk and blow away the
> journal. *That* should fix its little red wagon.

Or, you can optionally use the "rootfstype=ext2" kernel option, to avoid
the need to remove and then re-create the journal.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

