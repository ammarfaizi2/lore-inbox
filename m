Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRBYXne>; Sun, 25 Feb 2001 18:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130002AbRBYXnY>; Sun, 25 Feb 2001 18:43:24 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:2696 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129998AbRBYXnK>; Sun, 25 Feb 2001 18:43:10 -0500
Message-ID: <3A99986F.1AC6A46F@yahoo.co.uk>
Date: Sun, 25 Feb 2001 18:42:39 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Reply-To: jdthoodREMOVETHIS@yahoo.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Should isa-pnp utilize the PnP BIOS?
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, l-k.

On my ThinkPad 600, The ThinkPad PnP BIOS configures
all PnP devices at boot time.

If I load the isa-pnp.o driver it never detects any ISA PnP
devices: it says "isapnp: No Plug & Play device found".  This
is unfortunate, because it means that device drivers can't
find out from isa-pnp where the devices are.

David Hinds's pcmcia-cs package contains driver code that
interfaces with the PnP BIOS.  With it, one can list the resource
usage of ISA PnP devices (serial and parallel ports, sound chip,
etc.) and set them, using the "lspnp" and "setpnp" commands.

Would it not be useful if the isa-pnp driver would fall back
to utilizing the PnP BIOS (if possible) in order to read and
change ISA PnP device configurations when it can't do this
itself?  If so, could this perhaps be done by bringing the Hinds
PnP BIOS driver into the kernel and interfacing isa-pnp to it?

Thomas Hood
jdthood_AT_yahoo.co.uk   <- Change '_AT_' to '@'
