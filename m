Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbSJHTau>; Tue, 8 Oct 2002 15:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSJHT33>; Tue, 8 Oct 2002 15:29:29 -0400
Received: from khms.westfalen.de ([62.153.201.243]:23517 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S263315AbSJHT3U>; Tue, 8 Oct 2002 15:29:20 -0400
Date: 08 Oct 2002 21:03:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8YVxTrWXw-B@khms.westfalen.de>
In-Reply-To: <3DA1D2ED.6060305@ccs.neu.edu>
Subject: Re: bcopy()
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.33.0210071118220.1356-100000@penguin.transmeta.com> <3DA1D2ED.6060305@ccs.neu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stan@ccs.neu.edu (Stan Bubrouski)  wrote on 07.10.02 in <3DA1D2ED.6060305@ccs.neu.edu>:

> Linus Torvalds wrote:
> > On Mon, 7 Oct 2002, Christoph Hellwig wrote:
> >
> >>The lowlevel XFS code tries to stay in sync as much as possible with
> >>the IRIX codebase to make maintaince easier (we're a very small team..).
> >
> >
> > Could somebody drag the Irix team kicking and screaming into the 1980's,
> > please?
> >
>
> If it were that simple I'm sure it would have been done long
> ago, no?

How can it *not* be that simple?

No matter if you think bcopy should work for overlapping memory or not,  
there is a replacement standard function (by the 1989 ANSI C standard, so  
maybe the 1980's are not quite modern enough) that does exactly that, with  
nothing but rearranged parameters.

That's a purely mechanical change, on the same level as the kernel janitor  
stuff - hell, easier than the kernel janitor stuff.


I expect the reason it hasn't been done in Irix kernel code is simly that  
there was no real need to do it. I certainly do not imagine there's  
anything *hard* about it.

Hell, you could just use the #define method to map an XFS memcpy (or  
memmove) onto the Irix kernel library bcopy!

No, this is politics, not technical. (On both sides, of course.)

MfG Kai
