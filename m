Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424365AbWKKL3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424365AbWKKL3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424549AbWKKL3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:29:35 -0500
Received: from mx3.mail.ru ([194.67.23.149]:11549 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1424365AbWKKL3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:29:34 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: David Brownell <david-b@pacbell.net>
Subject: 2.6.19-rc5 regression: can't disable OHCI wakeup via sysfs
Date: Sat, 11 Nov 2006 14:29:55 +0300
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru> <200606192239.06208.arvidjaar@mail.ru> <200606191312.07063.david-b@pacbell.net>
In-Reply-To: <200606191312.07063.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111429.56345.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 20 June 2006 00:12, David Brownell wrote:
> > > > > An alternative (but post-boot) workaround _should_ be
> > > > >
> > > > >     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup
> > >
> > > Did that work?
> >
> > No. But
> >
> > 	echo -n disabled >
> > /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup
>
> That's what I meant ... thanks, and sorry for the confusion.

this does not work anymore in current rc5. After writing 
cat /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup shows "disabled" 
but messages continue to be logged.

Anything I can do to help narrow it down?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVbQ0R6LMutpd94wRApCwAKCDLKVxGWlE8vyf8sH42wU2RBVxHQCgl0rl
4vRC3bgKflRGboCrzF8YnJY=
=nuLl
-----END PGP SIGNATURE-----
