Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbTL2UUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbTL2UU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:20:26 -0500
Received: from imap.gmx.net ([213.165.64.20]:7076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265112AbTL2URd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:17:33 -0500
X-Authenticated: #552865
Date: Mon, 29 Dec 2003 21:24:32 +0100
From: Florian Schuele <schuele@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
Message-ID: <20031229202432.GA8418@spacken.de>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <20031229195235.GC26821@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229195235.GC26821@bounceswoosh.org>
X-PGP-KeyID: 0xBBCE086E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.12.03 12:52 -0700, Eric D. Mudama wrote:

> On Mon, Dec 29 at 11:07, Jonathan Kamens wrote:
> >The topic of CRC errrors from IDE drives has been discussed numerous
> >times on this list, and I've reviewed those discussions, but I'm still
> >not 100% certain of the answer to this question: Is it safe for me to
> >ignore occasional CRC errors from my drive?
> >
> >Here are the details....
> >
> >The errors look like this:
> >
> > hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >
> >They don't seem to happen often enough to convince the kernel to back
> >down to a slower UDMA mode.
> 
> 0x5184 is the error code for when the drive sends you data that was
> corrupted during transmission over the cable.  In general, nothing is
> wrong with your drive, and a re-read from the drive will almost always
> produce the proper data.
> 
> Odds are your cable is bad, regardless of how "good" it looks, you
> really can't tell if you have marginal conductivity on a pin or
> something else wierd.  In my home system I replace the IDE cables
> every few years, on my test box at work I replace them every month
> since I'm doing lots of re-plugging of drives. Note that a bad cable
> is *dangerous* to your filesystem, since a PIO transfer to the drive
> has *no* integrity checking on the cable!
> 
> Also, those "round" cables violate the ATA spec, I can't really
> recommend using them unless airflow is your #1 concern, however in
> that case you're probably better off buying a SATA drive.
> 
> Generic IDE ribbon cables (between 6" and 18") seem to work fine for
> most people, just go buy another $2 cable from CompUSA and see if the
> problem goes away.
> 
> FYI, UDMA4 isn't that fast, only 66MB/sec... "good" (functional, not
> brand name) flat cables should be able to do 100MB sec trivially.

i wrote a mail to this list a few days ago.
i have the same error messages as the above.
but _only_ with kernel 2.6.0, _not_ with 2.4.20 ...
thats strange. isnt it?
after i little traffic on the hd`s the system freezes.

-- 

florian schuele
