Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRDBQa5>; Mon, 2 Apr 2001 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRDBQar>; Mon, 2 Apr 2001 12:30:47 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:43269
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130388AbRDBQah>; Mon, 2 Apr 2001 12:30:37 -0400
Date: Mon, 23 Apr 2001 21:57:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Padraig Brady <Padraig@AnteFacto.com>
cc: Steffen Grunewald <steffen@gfz-potsdam.de>, linux-kernel@vger.kernel.org,
   rsmith@bitworks.com
Subject: Re: Cool Road Runner
In-Reply-To: <3AC8798B.5090302@AnteFacto.com>
Message-ID: <Pine.LNX.4.10.10104020738550.12531-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Padraig Brady wrote:

> OK can we just have a technical discussion?

Please, lets do, I am tired of the battles

>      I.E. no need for PCMCIA or any of that. I understood from your 
> responses
>      that you didn't realise this?

This valid that I do not know everything and that CFA does interesting
things more than what was specified in the past.

> 2. Compact Flash in this application (I.E. solid state hard disk) is 
> getting very
>      popular as prices are tumbling.
> 
> 3. Having a config parameter (uneeded kludge in my opinion), like hdx=flash
>      even if hdx is not a compact flash is confusing. Can we call it 
> hdx=probe
>      which fits nicely with the noprobe option.
> 
> 
> > I then explained why the detection was failing and pointed where to verify.
> 
> No you didn't. You mentioned a 30 second timeout, but not why it
> was caused. Have you seen this yourself or can you point us at who
> reported this to you?

Sorry phone call and email got mixed togather.
But I did explain that there could be a failure to detect if PDIAG/DASP
if one or the other devices was held to long and the wrong device reported
a signature in the task register.  Also that the if you reversed the two
device it would correctly report always.

>  
> > After 3-5 attempts and I can not get the point across because the other
> > party keeps going off in different directions to do "what about this",
> 
> Emm, I think *you* were going off describing your application with
> a "bazar ata-bridge", not the simple use of a compact flash as a
> hard disk.

Not quite, the electronic differences and flash in native mode is
incompatable, if you put it in to a mode that is 5V compatable then it
does seem possible and reasonable to work.  Your imperical data points
verify this issue.

What really needs to happen is that all the devices that are CFA-like
which require name parsing for detecting should have the "flash" rule
imposed.  Whereas the ones that correctly report 0x848A for word 0 of the
identify page may be exempt.

This seems like a reasonable step given that you are pointing out you
a have modern CFA's taht are more than just CFA's.

Would that work for you?

> 
> > I finally pointed out facts that distrub people, and gave up on trying to
> > show/present/give the answer and offered to then enforce their beliefs of
> > reality.
> > 
> > So I state a few facts very pointed to get their attention again and that
> > is additude??
> 
> Actually I thought the final email was a little more concise/informative, thanks.

Well I am glad that somebody gleened some information and providing
feedback so that forward progress is possible, and not the classic
battles.

Cheers,

Andre Hedrick
Linux ATA Development

