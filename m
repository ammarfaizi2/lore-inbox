Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131690AbRC0Woh>; Tue, 27 Mar 2001 17:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRC0WoR>; Tue, 27 Mar 2001 17:44:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131690AbRC0WoN>;
	Tue, 27 Mar 2001 17:44:13 -0500
Date: Tue, 27 Mar 2001 23:43:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
Message-ID: <20010327234308.B5411@flint.arm.linux.org.uk>
In-Reply-To: <E14i1ln-0004Tn-00@the-village.bc.nu> <3AC11145.58FDCFBB@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC11145.58FDCFBB@transmeta.com>; from hpa@transmeta.com on Tue, Mar 27, 2001 at 02:16:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 02:16:37PM -0800, H. Peter Anvin wrote:
> Alan Cox wrote:
> > A major for 'disk' generically makes total sense. Classing raid controllers
> > as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> > solve a lot of misery
> 
> But it might also cause just as much misery, specifically because things
> move around too much.

Actually, it probably won't.  As has already been said in the past, the
names are effectively a user space issue, but major numbers aren't.

I for one would like to see a major number for all 'serial ports' whether
they be embedded ARM serial ports _or_ standard 16550 ports, but at the
moment its not easily acheivable without introducing more mess.

Ted indicated to me a while ago (just after I wrote serial_core.c for
yet-another-type-of-ARM-serial-port) his visions of the direction serial
stuff should take in 2.5; this is obviously one of the things that I'm
keen to discuss and solve in 2.5.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

