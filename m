Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129750AbQKCBJC>; Thu, 2 Nov 2000 20:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbQKCBIm>; Thu, 2 Nov 2000 20:08:42 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:4648 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129750AbQKCBIb>;
	Thu, 2 Nov 2000 20:08:31 -0500
Date: Fri, 3 Nov 2000 03:15:46 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Greg KH <greg@wirex.com>, Johannes Erdfelt <johannes@erdfelt.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SUCCESS] Re: 2.2.18pre19
In-Reply-To: <20001102191625.T25191@sventech.com>
Message-ID: <Pine.LNX.4.10.10011030313160.1293-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short answer UHCI JE does work for me, no more strange errors...

The weird thig is that I have used 2.2 USB backports since the begining,
but I have always used the other UHCI, and up till now it used to work for
me, except for now, but now it seems to be ok w/ the JE variant.

Thanks for the help.

by,

SaPE

On Thu, 2 Nov 2000, Greg KH wrote:

> On Fri, Nov 03, 2000 at 02:08:53AM +0100, Sasi Peter wrote:
> > On Thu, 2 Nov 2000, Greg KH wrote:
> > 
> > > Could you send the result of /proc/interrupts and 'lspci -v'?
> > > Also, have you tried the alternate UHCI controller driver?
> > > Or tried USB as modules, instead of compiled in?
> > 
> > Here you go. I did work w/ the very same hw with pre15.
> 
> Looks like USB and your sound card is on the same interrupt.  Is there
> any BIOS settings you can make to move these around?
> 
> > I have never really knew what the UHCI JE was all about... So it can be
> > used in place of the original UHCI? I will make a try. (and why JE?)
> 
> Long story, short answer: 2 different developers working on support for
> the same device.  Both drivers work better for some people on different
> devices.  JE is the author's initials (Johannes Erdfelt).
> 
> Personally for some devices I have I like one version, for others, I
> like the other one.  Now if Johannes would ever fix the QUEUE_BULK bug,
> I would be back to using only one driver :)
> 
> Let me know if moving the IRQs helps out.
> 
> greg k-h
> 
> 
> -- 
> greg@(kroah|wirex).com
> http://immunix.org/~greg
> 

On Thu, 2 Nov 2000, Johannes Erdfelt wrote:

> On Fri, Nov 03, 2000, Sasi Peter <sape@iq.rulez.org> wrote:
> > On Thu, 2 Nov 2000, Greg KH wrote:
> > 
> > > Could you send the result of /proc/interrupts and 'lspci -v'?
> > > Also, have you tried the alternate UHCI controller driver?
> > > Or tried USB as modules, instead of compiled in?
> > 
> > Here you go. I did work w/ the very same hw with pre15.
> > 
> > I have never really knew what the UHCI JE was all about... So it can be
> > used in place of the original UHCI? I will make a try. (and why JE?)
> 
> Yes, it's a drop in replacement. Choose one or the other.
> 
> "JE" because it's my initials.
> 
> JE
> 

--  SaPE

Peter, Sasi <sape@sch.hu>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
