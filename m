Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261414AbREMP0m>; Sun, 13 May 2001 11:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbREMP0c>; Sun, 13 May 2001 11:26:32 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:27654 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261414AbREMP0Q>;
	Sun, 13 May 2001 11:26:16 -0400
Date: Sun, 13 May 2001 11:25:44 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jes Sorensen <jes@sunsite.dk>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010513112543.A16121@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jes Sorensen <jes@sunsite.dk>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <d33da9tjjw.fsf@lxplus015.cern.ch>; from jes@sunsite.dk on Sun, May 13, 2001 at 04:22:59PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sunsite.dk>:
> Not all cards have all features, not all users wants to enable all
> features.

Yes, I understand that.  You're not reading the derivations correctly.
Let's take an example:

derive MVME147_SCSI from MVME147 & SCSI

This doesn't turn on MVME147_SCSI on every MVME147 board.  It turns
on MVME147_SCSI when both MVME147 *and SCCI* are on.  So to suppress
MVME147_SCSI, one just leaves SCCI off.

All these derived symbols will still be controllable.  The difference
is that instead of being controlled by a low-level hardware-oriented
question they're controlled by a capability or subsystem symbol like
SCSI, NET_ETHERNET, or SERIAL.

> Eric> # These were separate questions in CML1 derive MAC_SCC from MAC
> Eric> & SERIAL derive MAC_SCSI from MAC & SCSI derive SUN3_SCSI from
> Eric> (SUN3 | SUN3X) & SCSI
> 
> As Alan already pointed out thats assumption is invalid.

I'm in touch with Ray Knight directly and will fix this as he requests.
 
> Yes I have objections. I thought I had made this clear a long time
> ago: Go play with another port and leave the m68k port alone.

Does this mean you'll take over maintaining the CML2 rules files
for the m68k port, so I don't have to?  That would be wonderful.

Reasoned objections can change my behavior.  Grunting territorial
challenges at me will not.  You have two options: (1) persuade Linus
that the whole CML2 thing is a bad idea and should be dropped, or (2)
work with me to correct any errors I have made and improve the system.
Growling at me and hoping I go away won't work, not when I've invested
a year's effort in this project.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

As with the Christian religion, the worst advertisement for Socialism
is its adherents.
	-- George Orwell 
