Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755664AbWKQKWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbWKQKWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbWKQKWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:22:44 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:49303 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1755664AbWKQKWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:22:43 -0500
Date: Fri, 17 Nov 2006 11:22:38 +0100
From: David Weinehall <tao@acc.umu.se>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117102237.GS14886@vasa.acc.umu.se>
Mail-Followup-To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <linux-acpi@vger.kernel.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107134439.1d54dc66.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 01:44:39PM -0800, Kristen Carlson Accardi wrote:
> On Tue, 7 Nov 2006 21:44:09 +0100
> David Weinehall <tao@acc.umu.se> wrote:
> 
> > On Mon, Nov 06, 2006 at 10:21:17AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> > > > > > info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> > > > > > (-mm1 behaves the same).
> > > > > 
> > > > > Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
> > > > > PCI Root Bridge whenever the lid opens up.
> > > > > 
> > > > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > > > it has no hotpluggable slots.
> > > > 
> > > > How about the docking station?
> > > 
> > > "Dock" for x60 only contains cdrom slot and aditional slots, no PCI or
> > > PCMCIA slots.
> > 
> > Well, when I press the undock button on the dock without the acpiphp
> > module loaded, I never get the green light that confirms that removing
> > the laptop is safe.  If acpiphp is loaded, things work just fine.
> > 
> > 
> > Regards: David
> > -- 
> >  /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
> > //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> > \)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
> 
> David,
> What kernel version are you using?  You should not need acpiphp to do
> docking on the X60.  If you are using a recent kernel, do you mind sending
> the dmesg output so we can figure out why this doesn't work for you?

That was with 2.6.17; with 2.7.19-pre? (don't remember right now),
docking seems to work without acpiphp.  It still would be nice to be
able to undock when the laptop is sleeping though; how do I achieve
that?


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
