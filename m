Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTDXKHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTDXKHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 06:07:06 -0400
Received: from [195.95.38.160] ([195.95.38.160]:48121 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262737AbTDXKHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 06:07:04 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Russell King <rmk@arm.linux.org.uk>, devilkin-lkml@blindguardian.org
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Thu, 24 Apr 2003 12:16:18 +0200
User-Agent: KMail/1.5.1
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304241206.43717.devilkin-lkml@blindguardian.org> <20030424111123.A25304@flint.arm.linux.org.uk>
In-Reply-To: <20030424111123.A25304@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304241216.24417.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 24 April 2003 12:11, Russell King wrote:
> On Thu, Apr 24, 2003 at 12:06:37PM +0200, DevilKin wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Thursday 24 April 2003 09:57, Russell King wrote:
> > > Maybe looking in /sysfs/bus/pci/drivers before inserting the card
> > > (this may cause an oops as well - if so, it confirms my suspicion.)
> >
> > Uh... The Maestro3 is integrated on the motherboard, so that's kinda
> > hard.
>
> Sorry, I meant booting without the cardbus card inserted, then looking
> at /sysfs/bus/pci/drivers.

devilkin@laptop:~$ tree /sys/bus/pci/drivers/
/sys/bus/pci/drivers/
|-- PIIX IDE
|   `-- 00:07.1 -> ../../../../devices/pci0/00:07.1
|-- cardbus
|   |-- 00:03.0 -> ../../../../devices/pci0/00:03.0
|   `-- 00:03.1 -> ../../../../devices/pci0/00:03.1
|-- ess_m3_audio
|   `-- 00:08.0 -> ../../../../devices/pci0/00:08.0
|-- parport_pc
|-- serial
`-- uhci-hcd
    `-- 00:07.2 -> ../../../../devices/pci0/00:07.2

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p7l1puyeqyCEh60RAkK0AJ48w7l9nl93DpKbQAldI7Q1nsMfkgCghNiP
IzwpmcKOxgGytMG+OQP20RI=
=SnTJ
-----END PGP SIGNATURE-----

