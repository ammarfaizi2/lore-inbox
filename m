Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRAMOH2>; Sat, 13 Jan 2001 09:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRAMOFq>; Sat, 13 Jan 2001 09:05:46 -0500
Received: from styx.suse.cz ([195.70.145.226]:48885 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130149AbRAMOFb>;
	Sat, 13 Jan 2001 09:05:31 -0500
Date: Sat, 13 Jan 2001 14:35:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010113143556.A1155@suse.cz>
In-Reply-To: <20010112204626.A2740@suse.cz> <E14HDqv-0005Fm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14HDqv-0005Fm-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 12, 2001 at 11:43:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 11:43:23PM +0000, Alan Cox wrote:
> > I'd like to hear about such reports so that I can start debugging (and
> > perhaps get me one of those failing boards, they must be quite cheap
> > these days).
> 
> This is one of the most precise reports I have
> 
> |The system is an AMD K6-3 on a FIC PA-2013 mobo with 3 IDE disks.  The
> |size of hda is 4.3 GB, the size of hdb is 854 MB and the size of hdc is
> |1.2 GB.  Hdd is an IDE CDROM drive
> 
> I think its significant that two reports I have are FIC PA-2013 but not all.
> What combination of chips is on the 2013 ?

As far as I know the same as on FIC VA-503+, that is vt82c598 north and
vt82c586b south - the MVP3 chipset. I've got the VA-503+ here and it
works really well. the 503+ and the 2013 differ only in form factor, one
is Baby AT (503+) and the other is ATX.

It's vt82c586b, and most probably 3041 silicon - the most bugless VIA
southbridge I know of ...

Weird. Could the person who reported it test the 2.4.0 kernel? I think
the 2.2 drivers had some MVP3 (and 3041 silicon)  related bugs. 3041 has
some registers layed out differently from all other chips.

Btw, this is not the 586 nor 586a, so changing the test to test for just
these two probably won't be the right thing to do ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
