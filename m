Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSKBWlP>; Sat, 2 Nov 2002 17:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSKBWlP>; Sat, 2 Nov 2002 17:41:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51210 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261472AbSKBWlP>;
	Sat, 2 Nov 2002 17:41:15 -0500
Date: Sat, 2 Nov 2002 23:47:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Patrick Finnegan <pat@purdueriots.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102224716.GA15134@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Patrick Finnegan <pat@purdueriots.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <20021102220658.C8549@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211022326090.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211022326090.13258-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:33:31PM +0100, Roman Zippel wrote:
> > | +You should rebuild lxdialog.  This can be done by moving to the
> > | +/usr/src/linux/scripts/lxdialog directory and issuing the "make clean all"
> > | +command.
> 
> $ cd /usr/src/linux/scripts/lxdialog
> -bash: cd: /usr/src/linux/scripts/lxdialog: No such file or directory
> $ cd scripts/lxdialog
> $ make clean
> Makefile:27: /Rules.make: No such file or directory
> make: *** No rule to make target `/Rules.make'.  Stop.
The proper way is to do the following:
	$(Q)$(MAKE) -f scripts/Makefile.clean obj=scripts/lxdialog

But thats only OK within a kbuild makefile.
Is there any real need for an external make clean for lxdialog?

	Sam
