Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGMU65>; Sat, 13 Jul 2002 16:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGMU65>; Sat, 13 Jul 2002 16:58:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64180 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315440AbSGMU64>;
	Sat, 13 Jul 2002 16:58:56 -0400
Date: Sat, 13 Jul 2002 13:52:35 -0700 (PDT)
Message-Id: <20020713.135235.83621938.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1026571615.9956.100.camel@irongate.swansea.linux.org.uk>
References: <1026527009.9958.69.camel@irongate.swansea.linux.org.uk>
	<20020712.181214.15590856.davem@redhat.com>
	<1026571615.9956.100.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 13 Jul 2002 15:46:55 +0100

   We still have people needing to find other devices

In particular things like "if on PCI host controller DEV/ID, enable hw
bug workaround foo".  I'm going to need to do crap like this even in
the TG3 driver, it has to be worked around in the TG3 driver code
itself so this isn't a PCI black-list type thing where we swizzle bits
in the PCI host controller registers.
