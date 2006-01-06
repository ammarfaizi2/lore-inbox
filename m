Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWAFQpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWAFQpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbWAFQpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:45:13 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:19465 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1752471AbWAFQpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:45:11 -0500
Message-ID: <43BE9E7E.60803@tuxrocks.com>
Date: Fri, 06 Jan 2006 09:44:46 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
References: <43ACEE14.7060507@feise.com>	 <200512252309.07162.dtor_core@ameritech.net>	 <43AF742E.5040604@tuxrocks.com>	 <200601042224.08509.dtor_core@ameritech.net>	 <43BE2A3A.9000706@tuxrocks.com> <d120d5000601060826p28ff7e69l96f0e0b9287c6c0f@mail.gmail.com>
In-Reply-To: <d120d5000601060826p28ff7e69l96f0e0b9287c6c0f@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> I just want to confirm that when testing the patch you forced the
> touchpad into PS/2 mode with psmouse.proto=exps, right?

Correct

> Could you please enable i8042 debug (echo 1 >
> /sys/modules/i8042/parameters/debug), move pointer and do coulple of
> taps and touble-taps making sure there is 5 seconds intervals between
> events and send me dmesg. Or is the mouse jerky and touchy even while
> you using it continuously, without 5 seconds pauses?

Odd.  Looks like we've got quotes around the names in /sys/module (but
only for those compiled in--actual modules show correctly).

Anyway, I used /sys/module/"i8042"/parameters/debug, and I'll send you
the dmesg in another email.

The mouse is jerkey and touchy both with and without 5 second pauses.  I
only see the complete mouse "stall" after 5-second pauses, though.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvp59aI0dwg4A47wRAv4aAJ9+J80OvGQ1GMCFEAM/lQUyxx4+awCgjl7o
Y98BW+9mtxLyxclKtsb4qig=
=ON28
-----END PGP SIGNATURE-----
