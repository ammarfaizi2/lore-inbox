Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277718AbRJZGIB>; Fri, 26 Oct 2001 02:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277670AbRJZGHv>; Fri, 26 Oct 2001 02:07:51 -0400
Received: from theuw.net ([209.23.48.158]:16067 "HELO narboza.theuw.net")
	by vger.kernel.org with SMTP id <S277656AbRJZGHo> convert rfc822-to-8bit;
	Fri, 26 Oct 2001 02:07:44 -0400
Date: Fri, 26 Oct 2001 02:08:19 -0400 (EDT)
From: <lung@theuw.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dan <lung@theuw.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Repeatable File Corruption (ECS K7S5A w/SIS735)
In-Reply-To: <20011026045736.77F08106D0@mail.medav.de>
Message-ID: <Pine.LNX.4.33.0110260205260.5131-100000@narboza.theuw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've received one report of someone using the same motherboard, but using
SCSI and having no issues.  I think after a little testing, this will
point directly at IDE.

I've made me test file available for more testing, but I think I can
dig up an old SCSI drive tomorrow to test this myself.


On Fri, 26 Oct 2001, Daniela Engert wrote:

> On Thu, 25 Oct 2001 22:21:47 -0400 (EDT), dan wrote:
>
> >  It is repeatable and verified on other boards of the same model.  This
> >just started happening when I upgraded the system.  The following is a
> >link to the ECS K7S5A board in question, the SIS735 chipset, and a
>
> >  hda: ST36421A, ATA DISK drive
> >  hdb: QUANTUM FIREBALLP LM10.2, ATA DISK drive
> >  hdc: IC35L060AVER07-0, ATA DISK drive
>
> >The problem only went away when I replaced the motherboard.  I also
> >haven't had any file corruption issues running Windows2000 on the same
> >hardware with the same files.  I moved all of the hardware in the original
> >system to a new motherboard (ASUS A7A266)  and the problem went away.
>
> >I have CC'd the IDE chipset maintainer because I can only assume it might
> >be related.
>
> It very likely is. The current Linux SiS IDE driver doesn't initialize
> the the EIDE controller in the SiS735 (and most likely all other
> ATA/100 capable members, too) correctly.
>
> The SiS735 IDE cycle timing registers have a layout that is different
> from the older predecessors!
>
> >From my experiences, drivers taking this not into account *do* actually
> work most of the time even if the timing of the layer 0 communication
> protocol is wrong, but fail mysteriously sometimes. Andre needs to
> update the SiS5513 code.
>
> Ciao,
>   Dani
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Daniela Engert, systems engineer at MEDAV GmbH
> Gräfenberger Str. 34, 91080 Uttenreuth, Germany
> Phone ++49-9131-583-348, Fax ++49-9131-583-11
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


