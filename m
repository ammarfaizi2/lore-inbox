Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292396AbSBYX33>; Mon, 25 Feb 2002 18:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292397AbSBYX3U>; Mon, 25 Feb 2002 18:29:20 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:20976 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292396AbSBYX3J>;
	Mon, 25 Feb 2002 18:29:09 -0500
Date: Mon, 25 Feb 2002 16:28:05 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe.ml@online.fr>,
        linux-pm-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume and 3c59x
Message-ID: <20020225162805.Q12832@lynx.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	=?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe.ml@online.fr>,
	linux-pm-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020225200056.GW12719@ufies.org> <3C7A9C75.F6A4BA05@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7A9C75.F6A4BA05@zip.com.au>; from akpm@zip.com.au on Mon, Feb 25, 2002 at 12:20:05PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 25, 2002  12:20 -0800, Andrew Morton wrote:
> christophe barbé wrote:
> > I use the kernel 2.4.17 and the hotplug facilities for my 3com cardbus
> > (driver 3c59x). It works well when I insert and remove the card.
> > But If I don't remove the card before suspending (apm -s) my laptop,
> > The card is in a bad state when I resume the laptop and I need to remove
> > and insert the card to get it back. I have tried to ifdown and rmmod
> > before suspending but the result is the same.
> 
> Did you provide the `enable_wol=1' module parameter?
> 
> 	options 3c59x enable_wol=1
> 
> Despite its name, this turns on some power management
> functionality.  Should have been a separate "enable_pm".

Hmm, I have a similar problem with my Xircom 10/100 adapter (xirc2ps_cs).
On resume it never works, so I eject/insert it each resume (via cardctl).
My 3cce589et (10Mbps) card does not have this problem.

In dmesg xirc2ps_cs reports:
eth0: media 10Base2, silicon revision 4

On a normal insertion it reports:
eth0: MII link partner: 0081
eth0: MII selected
eth0: media 100BaseT, silicon revision 5

I'm not sure if that is the real problem or just a symptom.  I'll have to
look if it supports the enable_wol parameter...  Nope.  Any ideas?  2.4.17

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

