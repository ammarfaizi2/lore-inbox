Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280705AbRKGALm>; Tue, 6 Nov 2001 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280695AbRKGALc>; Tue, 6 Nov 2001 19:11:32 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:42234 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280705AbRKGALU>;
	Tue, 6 Nov 2001 19:11:20 -0500
Date: Tue, 6 Nov 2001 17:10:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Philip Blundell <philb@gnu.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lp.c, eexpress.c jiffies cleanup
Message-ID: <20011106171023.A5922@lynx.no>
Mail-Followup-To: Philip Blundell <philb@gnu.org>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111062039440.23693-100000@gans.physik3.uni-rostock.de> <20011106141521.R3957@lynx.no> <adilger@turbolabs.com> <E161Duo-0000jO-00@kc.cam.armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E161Duo-0000jO-00@kc.cam.armlinux.org>; from philb@gnu.org on Tue, Nov 06, 2001 at 09:37:50PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2001  21:37 +0000, Philip Blundell wrote:
> In message <20011106141521.R3957@lynx.no>, Andreas Dilger writes:
> >I agree.  It seems very ugly.  I looked at a few drivers which loop 1 or 2
> >jiffies, but to busy-loop for 1/10th of a second, or even 20 seconds
> >is terribly bad. 
> 
> Those timeouts are only a last resort.  If the card is working properly
> the loop will terminate much sooner.

Well, if the card is working properly, then you don't need the timeouts
at all.  Clearly, if they are needed, then either they should be more
realistic in length (1/10th isn't bad, but 20 seconds?), or after a
"reasonable" short timeout, it should sleep for an interval and check
afterwards.  Sucking all CPU for 20 seconds and locking everything else
out isn't an acceptable method IMHO.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

