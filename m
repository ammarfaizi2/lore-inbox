Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbTDXJzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDXJzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:55:23 -0400
Received: from [195.95.38.160] ([195.95.38.160]:58095 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S261855AbTDXJzW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:55:22 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Russell King <rmk@arm.linux.org.uk>, devilkin-lkml@blindguardian.org
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Thu, 24 Apr 2003 12:06:37 +0200
User-Agent: KMail/1.5.1
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304240940.21553.devilkin-lkml@blindguardian.org> <20030424085756.A9597@flint.arm.linux.org.uk>
In-Reply-To: <20030424085756.A9597@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200304241206.43717.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 24 April 2003 09:57, Russell King wrote:
> On Thu, Apr 24, 2003 at 09:40:18AM +0200, DevilKin-LKML wrote:
> > I have a Maestro3 in the laptop (which is also why the module is loaded),
> > but I never unload it once it's loaded at bootup...
> >
> > Anything else I can try?
>
> Maybe looking in /sysfs/bus/pci/drivers before inserting the card
> (this may cause an oops as well - if so, it confirms my suspicion.)

Uh... The Maestro3 is integrated on the motherboard, so that's kinda hard.

I have 1 pcmcia card and 1 cardbus card in the system (see below). 
I have tested the booting with no cards, than it boots fine. Booting with only
the pcmcia card also works fine, so It's really the cardbus card that seems to 
throw the system into an unstable state.

laptop:/home/devilkin# cardctl ident
Socket 0:
  product info: "3Com Corporation", "3CCFE575BT", "LAN Cardbus Card", "001"
  manfid: 0x0101, 0x5157
  function: 6 (network)
Socket 1:
  product info: "Psion Dacom", "Gold Card Global 56K+Fax", "56K+Fax", "V8.25"
  manfid: 0x016c, 0x0005
  function: 2 (serial)

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p7cvpuyeqyCEh60RAtLVAJwOVfwwZ0RyTG5UwqprhYK2yibtlgCfbWRP
v0glplXaF6gJbQ+83/bqS/k=
=Au0c
-----END PGP SIGNATURE-----

