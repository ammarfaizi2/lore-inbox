Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSBMSaY>; Wed, 13 Feb 2002 13:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSBMSaV>; Wed, 13 Feb 2002 13:30:21 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:38582 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S288342AbSBMSaA>; Wed, 13 Feb 2002 13:30:00 -0500
Date: Wed, 13 Feb 2002 18:30:01 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
In-Reply-To: <E16axOE-0004zX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202131824530.29582-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Just a note that I have almost exactly the setup you outlined on a 
KT7A-RAID, HPT370 onboard.

I have a single disk on each highpoint chain, and a 3rd (parity) on 
one of the onboard 686B channels.

I have been seeing odd corruptions since I setup the system as RAID-5 
though.  Have you seen any reports of 686B ide corruption recently (or 
RAID-5 for that matter) ?

kernel 2.4.18pre6... just compiling pre9-ac3...
Athlon MP 1500+, mem=nopentium apm=off, NvAGP=0 in X-setup.

Mark

On Wed, 13 Feb 2002, Alan Cox wrote:

> Date: Wed, 13 Feb 2002 11:15:54 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Marco Colombo <marco@esi.it>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
> Subject: Re: Quick question on Software RAID support.
> 
> > 	 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Is it supposed to detect a failed disk and *stop* using it?
> 
> Yes, it will stop using it and if appropriate try and do a rebuild
> 
> > I had a raid1 IDE system, and it was continuosly raising hard errors on
> > hdc (the disk was dead, non just some bad blocks): the net result was that
> > it was unusable - too slow, too busy on IDE errors (a lot of them - even
> > syslog wasn't happy).
> 
> Don't try and do "hot pluggable" IDE raid it really doesn't work out. With
> scsi the impact of a sulking drive is minimal unless you get unlucky
> (I have here a failed SCSI SCA drive that hangs the entire bus merely by
> being present - I use it to terrify HA people 8))
> 
> > BTW, given a 2 disks IDE raid1 setup (hda / hdc), does it pay to put a
> > third disk in (say hdb) and configure it as "spare disk"? I've got 
> > concerns about the slave not actually beeing able to operate if the
> > master (hda) fails badly.
> 
> Well placed concerns. I don't know what Andre thinks but IMHO spend the
> extra $20 to put an extra highpoint controller in the machine for the third
> IDE bus.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

