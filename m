Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277598AbRJZGBa>; Fri, 26 Oct 2001 02:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277656AbRJZGBT>; Fri, 26 Oct 2001 02:01:19 -0400
Received: from astcc-166.astound.net ([24.219.123.215]:7684 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S277598AbRJZGBE> convert rfc822-to-8bit; Fri, 26 Oct 2001 02:01:04 -0400
Date: Thu, 25 Oct 2001 23:02:02 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Daniela Engert <dani@ngrt.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dan <lung@theuw.net>
Subject: Re: Repeatable File Corruption (ECS K7S5A w/SIS735)
In-Reply-To: <20011026045736.77F08106D0@mail.medav.de>
Message-ID: <Pine.LNX.4.10.10110252300580.800-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniela,

I just love it when you bust my crops, dear ;-)
How about some init code to resolve the problem?

Cheers,

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

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Tel: (510) 857-0055 x103
38875 Cherry Street                           Fax: (510) 857-0010
Newark, CA 94560                              Web: www.aslab.com

