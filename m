Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292879AbSBVOrG>; Fri, 22 Feb 2002 09:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292883AbSBVOq5>; Fri, 22 Feb 2002 09:46:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24072 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292879AbSBVOqt>;
	Fri, 22 Feb 2002 09:46:49 -0500
Message-ID: <3C7659D8.1D85CF4A@mandrakesoft.com>
Date: Fri, 22 Feb 2002 09:46:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz> <3C7652B6.1040008@evision-ventures.com> <20020222153806.A5783@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Feb 22, 2002 at 03:16:22PM +0100, Martin Dalecki wrote:
> > > I think it'd be even better if the chipset drivers did the probing
> > > themselves, and once they find the IDE device, they can register it with
> > > the IDE core. Same as all the other subsystem do this.
> >
> > Well the lists are needed for quirk handling in the ide-pci.c code.
> > But if it turns out to be possible - I'm all for it.
> 
> I don't think so. If needed we can make some generic IDE_QUIRK_XXX
> defines which then the chipset drivers can use where applicable, passing
> them to the generic code.

It depends on the quirk, really, whether you want the low-level chipset
driver to set a flag that tells the IDE core to do something, or whether
the low-level chipset driver handles the quirk (by a fixup in an IRQ
routine or somesuch).

Basically it's a case-by-case basis...

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
