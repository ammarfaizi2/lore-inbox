Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310183AbSB1WnP>; Thu, 28 Feb 2002 17:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310179AbSB1WlH>; Thu, 28 Feb 2002 17:41:07 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:6142 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S310189AbSB1Wix>;
	Thu, 28 Feb 2002 17:38:53 -0500
Date: Thu, 28 Feb 2002 15:37:49 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020228153749.K11618@lynx.adilger.int>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com> <20020228160552.C23019@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020228160552.C23019@devcon.net>; from aferber@techfak.uni-bielefeld.de on Thu, Feb 28, 2002 at 04:05:52PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2002  16:05 +0100, Andreas Ferber wrote:
> On Tue, Feb 26, 2002 at 01:34:27PM -0500, Richard B. Johnson wrote:
> > The disk space can't run out because you have simply moved
> > files that didn't exceed the disk space before they were moved.
> 
> But a user will end up unable to /free/ any diskspace. User tries
> something, generates a /huge/ error log filling up the quota/disk,
> oops, has to call sysadmin before work can go on... Five minutes
> later, the fix just tried didn't work, oops, has to call admin again,
> and so on. Do you /really/ want this?

This is just being silly.  Obviously the user will be able to delete
files from the .undelete directory, and a daemon to do automatic
cleanup was also proposed.  Thinking anything else is just being obtuse.

You could have the unlink() wrapper check that there is still some
free space/quota when it is doing the move, and if not it deletes
old files until there is free space/quota.  The daemon just does this
for you in the background to avoid slowing things down.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

