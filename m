Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSDPWXj>; Tue, 16 Apr 2002 18:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313929AbSDPWXi>; Tue, 16 Apr 2002 18:23:38 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:47603 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313925AbSDPWXi>; Tue, 16 Apr 2002 18:23:38 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 16 Apr 2002 16:21:56 -0600
To: bert hubert <ahu@ds9a.nl>, Olaf Fraczyk <olaf@navi.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416222156.GB20464@turbolinux.com>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Olaf Fraczyk <olaf@navi.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020416074748.GA16657@venus.local.navi.pl> <20020416233457.A1731@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 16, 2002  23:34 +0200, bert hubert wrote:
> On Tue, Apr 16, 2002 at 08:12:22AM +0000, Olaf Fraczyk wrote:
> > Hi,
> > I would like to know why exactly this value was choosen.
> > Is it safe to change it to eg. 1024? Will it break anything?
> > What else should I change to get it working:
> > CLOCKS_PER_SEC?
> > Please CC me.
> 
> Your uptime wraps to zero after 49 days. I think 'top' gets confused.

Trivially fixed with the existing 64-bit jiffies patches.  As it is,
your uptime wraps to zero after 472 days or something like that if you
don't have the 64-bit jiffies patch, which is totally in the realm of
possibility for Linux servers.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

