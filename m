Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281455AbRKTWfI>; Tue, 20 Nov 2001 17:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRKTWe7>; Tue, 20 Nov 2001 17:34:59 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34041 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281440AbRKTWen>;
	Tue, 20 Nov 2001 17:34:43 -0500
Date: Tue, 20 Nov 2001 14:58:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Dale Amon <amon@vnl.com>, "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
Message-ID: <20011120145816.D1308@lynx.no>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011120190316.H19738@vnl.com> <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com> <20011120212055.A22590@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011120212055.A22590@vnl.com>; from amon@vnl.com on Tue, Nov 20, 2001 at 09:20:55PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  21:20 +0000, Dale Amon wrote:
> I presume IEEE station address == MAC...
> 
> I haven't really much choice. I can't use modules for
> security reasons; I have to assign the motherboard MAC
> to eth0 because a commercial package we are installing
> licenses on the MAC address of eth0.  

Hmm, the drawbacks of such a licensing system are numerous under
Linux, and are virtually unenforcable.  Simply set the eth0 MAC
address to be whatever you like.  It shouldn't be too hard, and
it will also ensure that your expensive software will continue
to be available if you should ever have to swap the motherboard
because of hardware problems, or an upgrade.

Looking at ifconfig(8), it looks like the following will work:

ifconfig eth0 hw ether 01:23:45:67:89:ab

I just tested this and it appears to work on my card (xirc2ps_cs)
after I unconfigured the interface (couldn't do it while up),
and I checked on a remote host that it also appears with this
MAC to arp.  This is ifconfig 1.39 (1999-03-18) and kernel 2.4.13.


Note that I'm not advocating stealing the software (or using more
than the number of licensed copies), just in making the situation
much more convinient for you.


This is, once again, is a situation where describing the real
goal, as opposed to the immediate problem, is much more likely to
get you a usable solution.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

