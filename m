Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSEBW2u>; Thu, 2 May 2002 18:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314683AbSEBW2t>; Thu, 2 May 2002 18:28:49 -0400
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:2553
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S314682AbSEBW2s>; Thu, 2 May 2002 18:28:48 -0400
Message-ID: <09fa01c1f227$c8357f00$6502a8c0@jeff>
From: "Jeff Nguyen" <jeff@aslab.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Pavel Machek" <pavel@suse.cz>,
        "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20020502215833.V31556@unthought.net> <E173N9y-0004k1-00@the-village.bc.nu> <20020502231359.W31556@unthought.net>
Subject: Re: IDE hotplug support?
Date: Thu, 2 May 2002 15:22:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can get a sustained read speed of 80MB/s on the Adaptec 2000S
Zero Channel RAID with 7 drives (RAID-5). But the sustained write
speed is only around 32MB/s.

On the other hand, the 3Ware Escalade 7850 can sustain a read speed
of 130MB/s with 8 drives (RAID-5). The write speed is 30MB/s.

Jeff

----- Original Message -----
From: "Jakob Østergaard" <jakob@unthought.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Martin Dalecki" <dalecki@evision-ventures.com>; "Pavel Machek"
<pavel@suse.cz>; "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>;
<linux-kernel@vger.kernel.org>
Sent: Thursday, May 02, 2002 2:13 PM
Subject: Re: IDE hotplug support?


> On Thu, May 02, 2002 at 09:26:38PM +0100, Alan Cox wrote:
> > > >=20
> > > > 8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
> > > > a classical RAID controller card for this kind of
> > > > setup.
> > >
> > > Because RAID controllers do not use the PCI bus ???    ;)
> >
> > The raid card transfers the data once, software raid once per device for
> > Raid 1/5 - thats a killer.
>
> For RAID-1 it's a killer (for writes), I agree.
>
> But I really doubt it would be so horrible for RAID-5 - after all, it's
only
> one extra block (the parity block) for each N-1 blocks written (for an N
disk
> RAID-5).  The penalty should be less, the more disks you have in the
array.
>
> But seriously, has anyone out there ever seen a hardware RAID controller
with
> a *sustained* RAID-5 thoughput of more than 60 MB/sec ?   Not that I think
it
> is impossible, but I've never heard about it.  Enlighten me, please, and
not
> with marketing numbers...
>
> >
> > > By the way, has anyone tried such larger multi-controller setups, and
t=
> > > ested
> > > the bandwidth in configurations with multiple PCI busses on the board,
=
> > > versus a
> > > single PCI bus ?
> >
> > With 2.4 yes. With all the 2.5 changes no.
>
> Did you get any speedup ?  Were you close to PCI bus saturation in the
one-bus
> scenario ?
>
> --
> ................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob Østergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

