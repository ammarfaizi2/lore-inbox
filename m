Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272168AbRIENHK>; Wed, 5 Sep 2001 09:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272169AbRIENHB>; Wed, 5 Sep 2001 09:07:01 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:26643 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272168AbRIENG6>; Wed, 5 Sep 2001 09:06:58 -0400
Message-ID: <3B962319.F9B710B4@t-online.de>
Date: Wed, 05 Sep 2001 15:05:29 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dl8bcu@dl8bcu.de
CC: Antonio Miguel Trindade <trindade@dei.uc.pt>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de> <3B95EA8F.93B27304@t-online.de> <200109051027.f85ARmM10012@polaris.dei.uc.pt> <3B960208.7121318@t-online.de> <20010905112127.A21405@Marvin.DL8BCU.ampr.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Kranzkowski schrieb:
> 
> On Wed, Sep 05, 2001 at 12:44:24PM +0200, Frank Schneider wrote:
> > Antonio Miguel Trindade schrieb:
> > > Em Quarta 05 Setembro 2001 10:04, Frank Schneider escreveu:
> > > > Olaf Zaplinski schrieb:
> > > >
> > > > I had this effect too here (RH7.1, Kernel 2.4.3), but i put it on a
> > > > wrong termination of the LVD Bus...be careful if you have LVD-Drives
> > > > with a "Termination"-Jumper...(e.g. IBM DGHS18V)...this Termination is
> > > > only usable if you use the drive as Single Ended SCSI-UW, *not* if you
> > > > use the drive i a true LVD-environment !
> > > >
> > >
> > >    According to IBM specs, _no LVD drive has terminators built-in_... I have
> 
> There are definitely some that have this SE-Termination jumper.

Yes...i can send you one if you send me a spare-drive instead...:-))
 
> >
> > But as said, my DGHS-Disk has a build-in terminator for use with
> > UW-buses...the bad thing is, that if you "terminate" the LVD-bus with
> > this, it seems to work...for some time...i had "/" on it and a part of
> > my /home-RAID5, and it run 2 weeks....
> 
> Usually when a single device in a LVD chain is operated in SE mode all LVD
> devices also switch to SE mode automatically. The use of a SE terminator
> such as the one on your harddisk qualifies for SE operation.

Thats exactly what i expected, but that did not happen...i tried this
one time by setting the "SE"-Jumper on *all* devices *and* connecting
them to the UW-cable (i use a Asus P2B-DS-Mobo with 3 connectors,
Fast-SCSI, UW-SCSI, LVD-SCSI)..their it worked in the described way, but
on the LVD-cable not even the SCSI-Bios at bootup mentioned the
problem...all devices were "LVD-SCSI" rated, and not "SE/FastSCSI" at
bootup...and /proc/scsi/aic7xxx/0 also said something about "80MByte/sec
synchronous speed..."

It seems that in this particular case you don`t get any hint where the
problem lies...neither from the bios nor from the driver...i noticed it
when i changed the LVD-cable and took a closer look on the disks...and
then in the specs on www.storage.ibm.com....

> But in SE mode you are tied to the much stricter specifications like length
> of cable etc. compared to LVD mode.

Thats clear...max. cablelength is 1,50m (if more than 4 devices are
connected), all together, incl. Fast-SCSI-cable or external cables, if
used...

> So maybe you just exceeded specifications too much.

I did this also one time (6 Devices-2m cablelength) and it showed indeed
the same problems...randomly appearing crashes on the scsi-bus,
sometimes revoverable, sometimes not, sometimes under heavy disk-load,
sometimes without...

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
