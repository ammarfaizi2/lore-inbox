Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSK0Vq4>; Wed, 27 Nov 2002 16:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSK0Vq4>; Wed, 27 Nov 2002 16:46:56 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:30728 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S264788AbSK0Vqz>;
	Wed, 27 Nov 2002 16:46:55 -0500
Date: Wed, 27 Nov 2002 22:54:13 +0100
From: Martin Mares <mj@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: how to list pci devices from userpace?  anything better than /proc/bus/pci/devices?
Message-ID: <20021127215413.GA5277@ucw.cz>
References: <3DE537FC.6090105@nortelnetworks.com> <Pine.LNX.3.95.1021127163510.4690A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021127163510.4690A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Red Hat distributions after 7.0 provide `lspci`. You still have
> to parse ASCII. FYI, it's not hard to write a 'C' program
> that directly accessed the PCI bus from its ports at 0xCF8 (index)
> and 0xCFC (data). You need to do 32-bit port accesses and you
> can set iopl(3) from user-space.

Please DON'T do that -- not all machines support this access mechanism
and even on them directly poking the I/O ports would lead to races with
other programs and as well with the kernel.

Either use lspci (which has a nice machine-parseable output mode) or
parse /proc/bus/pci/devices or use the libpci library (part of the
pciutils package).

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A LISP programmer knows value of everything, but cost of nothing.
