Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbUJ0UCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUJ0UCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUJ0UAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:00:30 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:56720 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262676AbUJ0Tzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:55:39 -0400
Message-ID: <417FFD39.70601@comcast.net>
Date: Wed, 27 Oct 2004 15:55:37 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Reserving a syscall number
References: <417FED6E.3010007@comcast.net> <Pine.LNX.4.61.0410271505110.4669@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410271505110.4669@chaos.analogic.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



linux-os wrote:
| On Wed, 27 Oct 2004, John Richard Moser wrote:
|
|> -----BEGIN PGP SIGNED MESSAGE-----
|> Hash: SHA1
|>
|> How would one go about having a specific syscall number reserved in
|> entry.S?  I'm exploring doing a kill inside the kernel from a detection
|> done in userspace, which would allow the executable header of the binary
|> to indicate whether the task should be killed or not; if it works, the
|> changes will likely not go into mainline, but will still require a
|> non-changing syscall index (assuming I understood the syscall manpage
|> properly).
|>
|> On a side note, if a syscall doesn't exist, how would that be detected
|> in userspace?
|> - --
|
|
| Look at ld.so.preload for potential capabilities to control any
| executable.
|
| Also what's the problem with sending the task a signal when
| the detection has been done?
|
| If the usual capabilites are not sufficient, then make
| a driver (module).
|

I'm attempting to figure a way to control the IBM stack smash protector
via a flag in the ELF header, without opening the executable image on
disk and checking manually.  If there is a way to do this from
userspace, that would be acceptable.

|
| Cheers,
| Dick Johnson
| Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
|  Notice : All mail here is now cached and reviewed by John Ashcroft.
|                  98.36% of all statistics are fiction.
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBf/04hDd4aOud5P8RAm0AAJ9FWZ2d0hJpS5qDhogRPM6mWZJDOwCfe5YC
BynHiZzH94hn5XnSLZlNqyc=
=jMqN
-----END PGP SIGNATURE-----
