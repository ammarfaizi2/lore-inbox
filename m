Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbREQANm>; Wed, 16 May 2001 20:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbREQANc>; Wed, 16 May 2001 20:13:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261357AbREQANU>; Wed, 16 May 2001 20:13:20 -0400
Message-ID: <3B031766.F126904A@transmeta.com>
Date: Wed, 16 May 2001 17:12:22 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<E150B5B-0004fs-00@the-village.bc.nu> <200105162358.f4GNwll13400@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Alan Cox writes:
> > > Argh! What I wrote in text is what I meant to say. The code didn't
> > > match. No wonder people seemed to be missing the point. So the line of
> > > code I actually meant was:
> > >     if (strcmp (buffer + len - 3, "/cd") != 0) {
> >
> > drivers/kitchen/bluetooth/vegerack/cd
> >
> > its the cabbage dicer still ..
> 
> No, because it violates the standard. Just as we can define a major
> number to have a specific meaning, we can define a name in the devfs
> namespace to have a specific meaning.
> 
> Yes, it's broken if someone writes a cabbage dicer driver and uses
> "cd" as the leaf node name for devfs.
> 
> Yes, it's broken if someone writes a cabbage dicer driver and uses
> the same major as the IDE CD-ROM or SCSI CD-ROM drivers.
> 

But unlike the latter case, your case isn't even self-enforcing. 
Furthermore, it puts a lot of future restrictions on the namespace, and
take it from me, you don't want to do that.

That, of course, is in addition to everything else...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
