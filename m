Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291383AbSBXVUi>; Sun, 24 Feb 2002 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291324AbSBXVUU>; Sun, 24 Feb 2002 16:20:20 -0500
Received: from altus.drgw.net ([209.234.73.40]:36869 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291321AbSBXVUG>;
	Sun, 24 Feb 2002 16:20:06 -0500
Date: Sun, 24 Feb 2002 15:19:23 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224151923.E1682@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224215422.B1706@ucw.cz>; from vojtech@suse.cz on Sun, Feb 24, 2002 at 09:54:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 09:54:22PM +0100, Vojtech Pavlik wrote:
> On Sun, Feb 24, 2002 at 02:29:03PM -0600, Troy Benjegerdes wrote:
> 
> > On Sun, Feb 24, 2002 at 01:18:33PM +0100, Martin Dalecki wrote:
> > > > Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
> > > > bus, and one on a 33mhz PCI bus?
> > > > 
> > > > Or am I missing something?
> > > 
> > > You are missing the fact that it didn't work before.
> > 
> > What hardware, chipsets, situations, etc did the previous code not work
> > on?
> >
> > There is no avoiding the fact you need some kind of per-IDE controller
> > data for the clock for that particular PCI device.
> 
> No. You don't need it. The base clock and multiplier are enough and you
> have the multiplier from PCI config.
> 
> > I believe there are systems with 33mhz pci and 50mhz pci. Trying to find a
> > 'common' base clock just seems to be an excercise in confusion. The only
> > thing that really makes sense is 'how fast is said PCI device clocked'.
> 
> Show me one.

There is one on my desk, using a gt64260 PowerPC bridge chip. It's got 
dual PCI busses, and each can be clocked independently.

Table 2-6. System Clock Selection
CPU &
Memory Bus Fast/3V PCI     Slow/5V PCI 
Speed      Bus Speed       Bus Speed SW7 Settings
133 MHz    66 MHz          33 MHz    0100 0010 
100 MHz    66 MHz          33 MHz    1111 1010
100 MHz    33 MHz          33 MHz    1010 1000
83 MHz     55 MHz          41 MHz    0111 1101
66 MHz     66 MHz          33 MHz    0101 0101
66 MHz     33 MHz          33 MHz    0000 0001

These is just a partial list of potential clock rates.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
