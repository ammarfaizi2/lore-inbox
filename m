Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAMOFz>; Sat, 13 Jan 2001 09:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRAMOFs>; Sat, 13 Jan 2001 09:05:48 -0500
Received: from styx.suse.cz ([195.70.145.226]:51701 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129983AbRAMOFi>;
	Sat, 13 Jan 2001 09:05:38 -0500
Date: Sat, 13 Jan 2001 15:02:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Heil <kerndev@sc-software.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010113150210.F1155@suse.cz>
In-Reply-To: <Pine.LNX.3.95.1010112162542.1292a-100000@scsoftware.sc-software.com> <Pine.LNX.4.10.10101121649220.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121649220.8097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 04:52:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 04:52:00PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 12 Jan 2001, John Heil wrote:
> 
> > On Sat, 13 Jan 2001, Alan Cox wrote:
> > 
> > > Date: Sat, 13 Jan 2001 00:25:28 +0000 (GMT)
> > > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > To: Linus Torvalds <torvalds@transmeta.com>
> > > Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
> > > Subject: Re: ide.2.4.1-p3.01112001.patch
> > > 
> > > > what the bug is, and whether there is some other work-around, and whether
> > > > it is 100% certain that it is just those two controllers (maybe the other
> > > > ones are buggy too, but the 2.2.x tests basically cured their symptoms too
> > > > and peopl ehaven't reported them because they are "fixed").
> > > 
> > > I've not seen reports on the later chips. If they had been buggy and then 
> > > fixed I'd have expected much unhappy ranting before the change
> > 
> > The "fix" was an hdparm command like hdparm -X66 -m16c1d1 /dev/hda.
> > Which I set for my VIA 686a on a Tyan mobo w a 1G Athlon.
> 
> Careful. It may be that your fix just avoids the corruption because the
> other changes make it ok - like the 16-sector multi-count thing maybe
> hides a problem that might still exist - it just changes the "normal"
> timing so that you won't ever see it in practice any more.
> 
> These kinds of magic interactions is why I'm not at all happy about driver
> changes until people really know what it was that caused it, and _know_
> that it's gone.
> 
> Anyway, for you the problem apparently happened even on a 686a, but just
> the 586 series. Correct?

Yes, but this is a different problem. No corruption was happening here.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
