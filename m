Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292878AbSBVOfq>; Fri, 22 Feb 2002 09:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292877AbSBVOfg>; Fri, 22 Feb 2002 09:35:36 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:61453 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S292875AbSBVOf1>; Fri, 22 Feb 2002 09:35:27 -0500
Date: Fri, 22 Feb 2002 15:36:40 +0100
From: Florian Hars <florian@hars.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridges in 2.4.18-rc3
Message-ID: <20020222143640.GA22031@bik-gmbh.de>
In-Reply-To: <20020222100118.GA13061@bik-gmbh.de> <Pine.LNX.4.21.0202220921520.28932-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202220921520.28932-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Fri, 22 Feb 2002, Florian Hars wrote:
> > Any reason why this:
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.1/0970.html
> > isn't in rc3? My machine still works as it should.
> 
> Do you mean adding the necessary PCI ID's ? 

That, and adding some code in drivers/ide/via82xxx.c,
  { "vt8233c", PCI_DEVICE_ID_VIA_8233C, 0x00, 0x2f, VIA_UDMA_100 },
is right now ifdef'ed out, and the entry for the vt8233a, which is
  { "vt8233a", PCI_DEVICE_ID_VIA_8233A, 0x00, 0x2f, VIA_UDMA_133 },
in 2.5.2, is missing (and there is no UDMA_133 in 2.4).

Right now I am running a 2.4.18-pre9 with a slightly modified
drivers/ide/(timing.h|via82xxx.c) from 2.5.2, and it works with
my vt8233a and an UDMA-100 disk, but this is of course not a 
conservative change. Maybe the patch by Vojtech Pavlik mentioned
in the message I referred to above is less radical.

Yours, Florian.
	
