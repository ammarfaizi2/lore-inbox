Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752570AbWAFWbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbWAFWbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbWAFWbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:31:03 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:36868 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1752566AbWAFWbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:31:01 -0500
Message-ID: <43BEEF95.5080507@tuxrocks.com>
Date: Fri, 06 Jan 2006 15:30:45 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
References: <43ACEE14.7060507@feise.com> <200512252309.07162.dtor_core@ameritech.net> <43AF742E.5040604@tuxrocks.com> <200601042224.08509.dtor_core@ameritech.net> <43BE2A3A.9000706@tuxrocks.com>
In-Reply-To: <43BE2A3A.9000706@tuxrocks.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank Sorenson wrote:
> Dmitry Torokhov wrote:
>>>Frank,
>>>
>>>Could you please try the patch below and see if it makes tapping work?
>>>Make sure you enable resynching by doing:
>>>
>>>	echo -n 5 > /sys/bus/serio/devices/serioX/resync_time
> 
> With this patch (on top of 2.6.15-mm1, right?), I see the mouse
> stall/jump problem, but tapping appears to continue working.  The
> touchpad also seems to be extremely touchy.  I get spurious taps with
> very little pressure, and sometimes double-tap will select, then
> immediately deselect.

Sorry, all.  I should have paid closer attention to the protocol it was
using.  This behavior turned out to be the result of the command-line
parsing issue that Sam Ravnborg's patch addresses.

With the touchpad back in the right mode, I see the original behavior
(tapping stops working) with both resync patches.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvu+VaI0dwg4A47wRArgiAJ4qxpieqLXvn1cNozB+w8BDlbN2BACg4K7Z
RfjchjnmcSEBUrUao5+lw2A=
=YzdX
-----END PGP SIGNATURE-----
