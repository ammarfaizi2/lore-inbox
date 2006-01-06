Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWAFI3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWAFI3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAFI3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:29:44 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:49156 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932375AbWAFI3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:29:43 -0500
Message-ID: <43BE2A3A.9000706@tuxrocks.com>
Date: Fri, 06 Jan 2006 01:28:42 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
References: <43ACEE14.7060507@feise.com> <200512252309.07162.dtor_core@ameritech.net> <43AF742E.5040604@tuxrocks.com> <200601042224.08509.dtor_core@ameritech.net>
In-Reply-To: <200601042224.08509.dtor_core@ameritech.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> On Sunday 25 December 2005 23:40, Frank Sorenson wrote:
> 
>>Dmitry Torokhov wrote:

>>>Does the tapping not work period or it only does not work first time you
>>>try to tap after not touching the pad for more than 5 seconds?
>>
>>The tapping works initially, then stops.  I hadn't put 2+2 together with
>>the 5-second idle bit, but that seems the likely issue.
>>
>>I applied that patch you sent out yesterday, and now tapping works and
>>I'm not seeing the mouse stall/jump problem.  I'm at 21+ hours uptime
>>now, with no mouse problems, so I think setting the resync_time to 0
>>looks like the right fix.

> Frank,
> 
> Could you please try the patch below and see if it makes tapping work?
> Make sure you enable resynching by doing:
> 
> 	echo -n 5 > /sys/bus/serio/devices/serioX/resync_time

With this patch (on top of 2.6.15-mm1, right?), I see the mouse
stall/jump problem, but tapping appears to continue working.  The
touchpad also seems to be extremely touchy.  I get spurious taps with
very little pressure, and sometimes double-tap will select, then
immediately deselect.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvio6aI0dwg4A47wRAmx5AJ9caJlziT8MfGdxSf/yzVhEGqxqfgCggE0M
P2wvTs9/Xbw/sXn8bc/Mk0Y=
=oGAz
-----END PGP SIGNATURE-----
