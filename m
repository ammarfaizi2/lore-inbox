Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135576AbRDSGrU>; Thu, 19 Apr 2001 02:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbRDSGrA>; Thu, 19 Apr 2001 02:47:00 -0400
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:31104 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S135577AbRDSGqu>; Thu, 19 Apr 2001 02:46:50 -0400
Date: Thu, 19 Apr 2001 08:46:35 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Martin Hamilton'" <martin@net.lut.ac.uk>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7
Message-ID: <20010419084635.D545@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9B@orsmsx35.jf.intel.com> <E14pyG2-0005c5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14pyG2-0005c5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 09:08:55PM +0100
X-Uptime: 07:01:49 up 24 min,  5 users,  load average: 0.93, 0.93, 0.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I was wondering whether the swsusp work might form a useful basis
> > > for the eventual ACPI implementation of the to-disk hibernation
> > > stuff:
> > 
> > I (and others) have looked at it. It's a pretty cool patch, but it
> > really isn't the right way to do things.
> 
> swsusp is most definitely the right way to do things. It works on my
> laptop which has non suspend to disk APM, it even works on my MVP3
> board where ACPI bombs totally (BIOS bug).
> 
> It might not be the right thing to do if ACPI suspend is present
> though.
> 
> Actually swsusp has one minor problem. Because of implementation bugs
> in some of the journalled file systems like ext3 using swsusp with
> those file systems can corrupt your disks (they write to disk even
> when told to mount read only rather than replaying the log to disk
> when the mount goes r/w - which is really antisocial, breaks if you
> are trying to recover from a failed disk and wants fixing.)

I tried swsusp on my vaio (also a c1ve :-) and it didn't work because it
(said it) couldn't stop [kreiserfsd]. :-(  It didn't do any harm also
afaics. 
I have zero experience with apm and acpi, but the thing I liked about
swsusp is that it works with a sysrq key combo. 

	Ookhoi
