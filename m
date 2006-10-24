Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWJXCp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWJXCp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWJXCp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:45:58 -0400
Received: from mx7.mail.ru ([194.67.23.27]:12314 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id S1030197AbWJXCp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:45:57 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Ordering hotplug scripts vs. udev device node creation
Date: Tue, 24 Oct 2006 06:45:38 +0400
User-Agent: KMail/1.9.5
Cc: "Aaron Cohen" <aaron@assonance.org>, linux-kernel@vger.kernel.org
References: <727e50150610231226p42b95cc4j686b31332c1d1c6e@mail.gmail.com>
In-Reply-To: <727e50150610231226p42b95cc4j686b31332c1d1c6e@mail.gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610240645.44542.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 23 October 2006 23:26, Aaron Cohen wrote:
> Adding a USB device seems to work correctly (more or less, my script
> is invoked a few too many times but I think I can figure out how to
> adjust my rule) using this.  I'm having trouble now with removal
> though.  By the time my script runs the device file has been removed
> by udev and I can't look it up through udevinfo any longer.  I need to
> know what the name of the device file was so I can tell gpsd to stop
> monitoring it.
>
> Any ideas?

udev sets DEVNAME and DEVLINKS environment before calling RUN program. You can 
either pass them directly like

RUN+="/your/program env{DEVNAME} env{DEVLINKS}"

or your program can get them from environment. It unfortunately seems to be 
not documented.

HTH

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFPX5YR6LMutpd94wRAsDrAJ92kOTrofNo3kg/5xW0C6bzm5TlDACg0/NG
K4R+tBQzCHJSN+XW5WBPghE=
=ZIet
-----END PGP SIGNATURE-----
