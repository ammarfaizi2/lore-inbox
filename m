Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277818AbRJZGlX>; Fri, 26 Oct 2001 02:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJZGlE>; Fri, 26 Oct 2001 02:41:04 -0400
Received: from theuw.net ([209.23.48.158]:41667 "HELO narboza.theuw.net")
	by vger.kernel.org with SMTP id <S277818AbRJZGky> convert rfc822-to-8bit;
	Fri, 26 Oct 2001 02:40:54 -0400
Date: Fri, 26 Oct 2001 02:41:30 -0400 (EDT)
From: <lung@theuw.net>
To: Andre Hedrick <andre@aslab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable File Corruption (ECS K7S5A w/SIS735)
In-Reply-To: <Pine.LNX.4.10.10110252331250.800-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0110260238570.5475-100000@narboza.theuw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You just let me know what you need me to do.  If you need some hands on, I
can throw up a box for you to break as well.  My service eagerly awaits.

Dan



On Thu, 25 Oct 2001, Andre Hedrick wrote:

>
> On Fri, 26 Oct 2001 lung@theuw.net wrote:
>
> >
> > I've received one report of someone using the same motherboard, but using
> > SCSI and having no issues.  I think after a little testing, this will
> > point directly at IDE.
> >
> > I've made me test file available for more testing, but I think I can
> > dig up an old SCSI drive tomorrow to test this myself.
> >
> >
> > On Fri, 26 Oct 2001, Daniela Engert wrote:
> >
> > > On Thu, 25 Oct 2001 22:21:47 -0400 (EDT), dan wrote:
> > >
> > > >  It is repeatable and verified on other boards of the same model.  This
> > > >just started happening when I upgraded the system.  The following is a
> > > >link to the ECS K7S5A board in question, the SIS735 chipset, and a
> > >
> > > >  hda: ST36421A, ATA DISK drive
> > > >  hdb: QUANTUM FIREBALLP LM10.2, ATA DISK drive
> > > >  hdc: IC35L060AVER07-0, ATA DISK drive
> > >
> > > >The problem only went away when I replaced the motherboard.  I also
> > > >haven't had any file corruption issues running Windows2000 on the same
> > > >hardware with the same files.  I moved all of the hardware in the original
> > > >system to a new motherboard (ASUS A7A266)  and the problem went away.
> > >
> > > >I have CC'd the IDE chipset maintainer because I can only assume it might
> > > >be related.
> > >
> > > It very likely is. The current Linux SiS IDE driver doesn't initialize
> > > the the EIDE controller in the SiS735 (and most likely all other
> > > ATA/100 capable members, too) correctly.
> > >
> > > The SiS735 IDE cycle timing registers have a layout that is different
> > > from the older predecessors!
> > >
> > > >From my experiences, drivers taking this not into account *do* actually
> > > work most of the time even if the timing of the layer 0 communication
> > > protocol is wrong, but fail mysteriously sometimes. Andre needs to
> > > update the SiS5513 code.
> > >
> > > Ciao,
> > >   Dani
> > >
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > Daniela Engert, systems engineer at MEDAV GmbH
> > > Gräfenberger Str. 34, 91080 Uttenreuth, Germany
> > > Phone ++49-9131-583-348, Fax ++49-9131-583-11
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> >
>
>
> Dan,
>
> If I give you a patch and a test tool kit, will you run destructive data
> tests?  If the low-level tool passes and the high-level fails we know it
> is not in the driver.  If the low-level fails then it is in the chipset
> setup code or the main loop.  If neither fail then it is random wrt the
> driver or the block layer above and time to get worried.
>
> Can you scratch a disk of content?
>
> Regards,
>
> Andre Hedrick
> CTO ASL, Inc.
> Linux ATA Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Tel: (510) 857-0055 x103
> 38875 Cherry Street                           Fax: (510) 857-0010
> Newark, CA 94560                              Web: www.aslab.com
>
>


