Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314610AbSDTM6K>; Sat, 20 Apr 2002 08:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314611AbSDTM6J>; Sat, 20 Apr 2002 08:58:09 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:21711 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S314610AbSDTM6I>; Sat, 20 Apr 2002 08:58:08 -0400
From: jordan.breeding@attbi.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trouble rebooting Tyan Thunder K7 (S2462UNG)
Date: Sat, 20 Apr 2002 12:58:02 +0000
X-Mailer: AT&T Message Center Version 1 (Nov 29 2001)
Message-Id: <20020420125803.FBRS1143.rwcrmhc51.attbi.com@rwcrwbc58>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry that I did not explain myself better the first time.  
The other OSes on this machine _do_ initialize a 
cold boot.  Here is how they _all_ reboot:  screen 
immediately goes black, hd light comes on as 
memory is ECC checked, hd light goes off and BIOS 
post screen comes up (monitor is now on again), 
Adaptec SCSISelect screen comes up, BIOS issues 
single beep and boots into GRUB.  This is the way 
that _all_ versions of linux reboot with _all_ reboot 
parameters:  screen hangs (but still has text on it, ie. 
the reboot messages) for at least 15-30 seconds, 
screen then goes blank, hd light comes on but _not_ 
for ecc check (during ecc check nothing is accessed 
except for memory) instead the system goes straight 
into SCSISelect once the screen goes blank and the 
hd light comes on (this is evident because during 
normal boot SCSISelect is the stage at which the hd 
light is on and each SCSI device is accessed in 
order), once SCSISelect has polled every id on the 
system it tries to hand back off to the BIOS which 
was apparently never initialized correctly during a 
Linux reboot since it issues a very weird series of 
eight or so BIOS beeps and then just sits there, the 
ecc memory is never polled, the BIOS post screen 
never comes up, the monitor never goes active 
again, the system is just hung at a black screen until 
I hard reboot it.  Other OSes _do_ perform a reboot 
in which ecc memory is polled however, so that 
does not seem to be the problem here.  Thanks for 
any more help anyone can offer.

Jordan Breeding
> On Fri, 2002-04-19 23:15:23 -0000, Jordan Breeding <jordan.breeding@attbi.com>
> wrote in message 
> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjQHXypTRWUeX0Da3WGxUUMKAAAAQAAAA
> b2jlXi9TM0a+IKeYbO47lAEAAAAA@attbi.com>:
> >   I am having trouble getting a brand new Tyan Thunder K7 S2462UNG (the
> > one with onboard SCSI) to reboot successfully using Linux.  This board
> 
> > FreeBSD do with this board, instead the text stays there for at least
> > 15-20 seconds (maybe longer) then when it finally blanks the video and
> > the monitor light begins to flash it goes straight into the Adaptec
> > SCSISelect scan (I can tell because my HD light comes on and the CDROMs
> 
> What is so uncommon? The board does use ECC RAM, so maybe the board's
> BIOS / firmware needs this time to blank and check all the RAM. Maybe
> othe OSes don't initiate a full "cold boot" but something that doesn't
> make the board to re-initialize all the RAM...
> 
> MfG, JBG
> 
> -- 
> Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
> 	 -- New APT-Proxy written in shell script --
> 	   http://lug-owl.de/~jbglaw/software/ap2/
> 
