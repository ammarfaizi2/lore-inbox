Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269421AbUINPjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269421AbUINPjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbUINPgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:36:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:23769 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269384AbUINPdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:33:20 -0400
Date: Tue, 14 Sep 2004 08:28:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: displaying kbuild dependancies ...
Message-Id: <20040914082841.4bde2c77.rddunlap@osdl.org>
In-Reply-To: <20040912213034.GD24240@MAIL.13thfloor.at>
References: <20040911202548.GA31680@MAIL.13thfloor.at>
	<20040911213931.GA22403@mars.ravnborg.org>
	<20040912213034.GD24240@MAIL.13thfloor.at>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 23:30:34 +0200 Herbert Poetzl wrote:

| On Sat, Sep 11, 2004 at 11:39:31PM +0200, Sam Ravnborg wrote:
| > On Sat, Sep 11, 2004 at 10:25:48PM +0200, Herbert Poetzl wrote:
| > > 
| > > Hi Sam!
| > > 
| > > first, thanks for the kbuild stuff and all the 
| > > time spent on that ... I really love it
| > > 
| > > 
| > > from time to time I encounter some issue which
| > > usually keeps me busy for a while, and I think
| > > there probably is a simpler solution to that ...
| > > 
| > > the procedure:
| > > 
| > > I'm configuring a 2.6.X-rcY-bkZ kernel for testing
| > > with QEMU, which in my setup basically requires
| > > some QEMU specific settings, I usually turn on/off
| > > by just editing the .config file by hand, and then
| > > invoking 'make oldconfig' ...
| > > 
| > > to keep the possibility for error low, I usually
| > > just remove the entries in question, and oldconfig
| > > will ask me the relevant question, leading to a
| > > nice config adapted to my purposes ...
| > > 
| > > the issue:
| > > 
| > > sometimes a dependancy doesn't allow me to remove
| > > a config option, I absolutely have to remove for
| > > my setup, like the VGA_CONSOLE, and then the hunt
| > > for the option 'requiring' that one unconditinally
| > > beginns ...
| > > 
| > > usually I start with grep and end with trial and
| > > error, until I find the malicious dependancy ...
| > 
| > The only option today is to turn on the debug option
| > in 'make xconfig'.
| 
| hmm, so no luck for the typical console user  :(
| 
| > I have been looking inot something better for menuconfig
| > but frankly kconfig is not where I feel most comfortable.
| 
| it would be sufficient to be able to turn on some
| debug output, which says 'foo selected from bla'
| or 'foo disabled, requires bla and whatnot' ...

There are some menuconfig patches in -mm (from Yuval Turgeman)
that add a search option (using '/') to menuconfig.
E.g., enter / + USB_STORAGE and you can see everywhere
that USB_STORAGE is used.... and that it SELECTs SCSI.
To see only the USB_STORAGE kconfig entry, use a regex:
^USB_STORAGE$

IIRC, Yuval is considering how to enhance this feature.

--
~Randy
