Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130774AbRAUQdY>; Sun, 21 Jan 2001 11:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRAUQdO>; Sun, 21 Jan 2001 11:33:14 -0500
Received: from styx.suse.cz ([195.70.145.226]:59125 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130774AbRAUQdC>;
	Sun, 21 Jan 2001 11:33:02 -0500
Date: Sun, 21 Jan 2001 17:32:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Message-ID: <20010121173251.B1073@suse.cz>
In-Reply-To: <20010121104606.A398@suse.cz> <Pine.Linu.4.10.10101211237230.2017-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.Linu.4.10.10101211237230.2017-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Jan 21, 2001 at 01:42:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 01:42:41PM +0100, Mike Galbraith wrote:
> On Sun, 21 Jan 2001, Vojtech Pavlik wrote:
> 
> > On Sat, Jan 20, 2001 at 02:57:07PM -0800, Andre Hedrick wrote:
> > 
> > > chipset ---\
> > >             |
> > >             \---------IDC-header
> > > 
> > > chipset ---+
> > >            |
> > >            +----------IDC-header
> > > 
> > > These are nearly the same but the corners cause bounce and iCRC's
> 
> I don't see how anyone can influence risetime falltime or impedance
> matching [1] issues via software timing changes.
> 
> (the top drawing is what you see on a poorly designed board.. long
> rise/fall times often cause worse problems than [slight] ringing)
> 
> > Well, there are other ways the motherboard maker can screw up the
> > traces, and often this happens:
> > 
> > chipset --------\
> >                 |
> > chipset ------\ |
> >               | \------ header
> >               \-------- header
> > 
> 
> Can you compensate for these things (to any degree?) in software?

Not really. Slowing the data rate down is in my opinion the only way to
compensate for this. Btw, the chipset only controls the write data rate
with UDMA. The read rate is controlled by the drive.

> 1.  Only a software guy would call it 'bounce'.. sounds funny ;-)

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
