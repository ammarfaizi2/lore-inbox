Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSFCNCA>; Mon, 3 Jun 2002 09:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315860AbSFCNB7>; Mon, 3 Jun 2002 09:01:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35469 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315805AbSFCNB5>; Mon, 3 Jun 2002 09:01:57 -0400
Date: Mon, 3 Jun 2002 15:01:30 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FUD or FACTS ?? but a new FLAME!
In-Reply-To: <3CFB0063.3070309@evision-ventures.com>
Message-ID: <Pine.SOL.4.30.0206031451580.17745-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jun 2002, Martin Dalecki wrote:

> Andre Hedrick wrote:
> > On Sun, 2 Jun 2002, Bartlomiej Zolnierkiewicz wrote:
> >
> >
> >>I apology for flames Andre, after some thinking I came to
> >>conclusion that if speaking hardware you are generally right.
> >>
> >>I hope we can together resolve transport layer issues in 2.5.
> >
> >
> > Bartlomiej,
> >
> > Thanks, and we worked well in the past togather, and there has never been
> > a communication problem with you.
> >
> > Lets hope so, and please change the maintainer file to your name.
> > As you were in mind in the past to replace me when I burned out.
>
> O co chodzi? Po prostu powinno siê przenie¶æ dwa typy host chipów
> intela do kategori - "mo¿e dzia³a jak chcesz to spróbuj":

Chodzi o to, zeby wreszcie rozwiazac niektore problemy z 2.5 n.p.
multi PIO...

>
> Ulf Axelsson to wszystko dawno ju¿ rozwi±za³:
>
> Hi Martin!
>
> (Note: This mail (and myself) is intentionally _NOT_ intended to go anywhere
> near linux-kernel and the regular flame fests. I'm as anonymous as one can
> be ;-)

No longer ;-) Perpare for flames ;)

>
> I have been reading the stuff about the difference between ATA/100 and
> ATA/133 talking about clock cycles, buffer sizes, transmission directions
> and what not and were quite unable to understand what the point was until I
> looked at the public Intel ICH4 spec (the one available to us mortals
> without connections :-)
>
> ftp://download.intel.com/design/chipsets/manuals/29860002.pdf
>
> Intel do state that the ICH4/82801DB supports only ATA/100 not ATA/133.
> Looking through some reviews on the net on the 845E/G they do say the same
> thing.
>
> In the light of that perhaps the code in drivers/ide/piix.c stating that the
> ICH4 does ATA/133 is a bit optimistic and should be moved to the "try it if
> you want to " CONFIG_BLK_DEV_PIIX_TRY133 option.
>
> Of course Vojtek might have better info that says otherwise.
>
> <<<CUTOUT>>>
> static struct piix_ide_chip {
>          unsigned short id;
>          unsigned char flags;
> } piix_ide_chips[] = {
>          { PCI_DEVICE_ID_INTEL_82801DB_9,        PIIX_UDMA_133 |
> PIIX_PINGPONG },
>                                                  ^^^^^^^^^^^^^
>
>                      /* Intel 82801DB ICH4 */
>          { PCI_DEVICE_ID_INTEL_82801CA_11,       PIIX_UDMA_100 |
> PIIX_PINGPONG },
>                      /* Intel 82801CA ICH3/ICH3-S */
>          { PCI_DEVICE_ID_INTEL_82801CA_10,       PIIX_UDMA_100 |
> PIIX_PINGPONG },
>                      /* Intel 82801CAM ICH3-M */
>          { PCI_DEVICE_ID_INTEL_82801E_9,         PIIX_UDMA_100 |
> PIIX_PINGPONG },
> <<<CUTOUT>>>
>
> Things would be easier if "you know who" could just say that according to
> public specs the ICH4 does not support ATA/133 instead of all that technical
> talk......
>

So, we should change it...

...and simple idea how to deal with overclocking IDE chipsets
-> try best we can but put some nice fat warning to user that
he will probably get screwed due to running chipset out of
specification...

> Regards,
> Ulf
>
> PS. It would be kind if you could tell me where the source to the new
> ide-info version you talked about can be found?

http://home.elka.pw.edu.pl/~bzolnier/atapci

