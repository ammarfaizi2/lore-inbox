Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267521AbSLLVnj>; Thu, 12 Dec 2002 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267522AbSLLVnj>; Thu, 12 Dec 2002 16:43:39 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:53891 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267521AbSLLVni>; Thu, 12 Dec 2002 16:43:38 -0500
Message-ID: <20021212215126.96688.qmail@web20508.mail.yahoo.com>
Date: Thu, 12 Dec 2002 13:51:26 -0800 (PST)
From: Benjamin Reed <br33d@yahoo.com>
Subject: Re: Status new-modules + 802.11b/IrDA 
To: Rusty Russell <rusty@rustcorp.com.au>, jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net
In-Reply-To: <20021212003733.2AF922C0E0@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I missed the original message.

As far as the timer message from airo_cs when you try
to remove the card:  This executes some code that is
pretty much common to all PCMCIA drivers that sets a
timer to do the actual driver removal asynchronous to
the REMOVAL event.  You can find it in airo_cs.c. 
I'll update the driver.

I haven't tried the recent 2.5 kernels, so I check if
I see anything.

ben 

In relation to:
--- Rusty Russell <rusty@rustcorp.com.au> wrote:
> In message
> <20021211174305.GB11264@bougret.hpl.hp.com> you
> write:
> > On Wed, Dec 11, 2002 at 07:34:53PM +1100, Rusty
> Russell wrote:
> > > > 	o removal of airo_cs : "Uninitialised
> timer!/nThis is a
> > > > warning. Your computer is OK". Call trace on
> demand. Also, the module
> > > > airo not removed (probably due to problem with
> airo_cs).
> > > 
> > > That, in itself, should be harmless.
> > 
> > 	Yes, but this is new and I don't really like it.
> I suspect
> > something is wrong in the Pcmcia code itself. Last
> I tried was 2.5.46
> > and I see some suspicious init_timer() added where
> I would not expect,
> > and some missing where they would be needed.
> > 	Hum... Who is in charge ?
> 
> Well, Andrew Morton made the change that required
> timers to be
> initialized, and the check which locates ones which
> are not.  As to
> who is responsible for airo_cs, I'm guessing Ben
> Reed, as author.
> 

