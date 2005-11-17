Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVKQTrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVKQTrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVKQTrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:47:18 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:26891 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S964785AbVKQTrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:47:17 -0500
Message-ID: <437CDE3D.90606@tuxrocks.com>
Date: Thu, 17 Nov 2005 12:47:09 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dag Nygren <dag@newtech.fi>
CC: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: nanosleep with small value
References: <20051117191119.15126.qmail@dag.newtech.fi>
In-Reply-To: <20051117191119.15126.qmail@dag.newtech.fi>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dag Nygren wrote:
> But what is the point of having a nanosleep() in that case when you could do
> just fine with usleep() ?

I'd suggest looking into the kthrt patches (which incorporates ktimers
and John Stultz's timeofday patches):  http://www.tglx.de/projects/ktimers/

Running your program, here are some results (latest git tree with the
latest kthrt and timeofday patches):

shortest of 10 runs as non-root:
real    0m0.418s
user    0m0.000s
sys     0m0.003s

longest of 10 runs as non-root:
real    0m0.794s
user    0m0.000s
sys     0m0.002s

shortest of 10 runs as root:
real    0m0.066s
user    0m0.001s
sys     0m0.007s

longest of 10 runs as root:
real    0m0.325s
user    0m0.000s
sys     0m0.004s

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDfN49aI0dwg4A47wRAoHxAKDTeMGGnv21qem2Ll+SG8x5q+pV7ACgpUiT
ru0P0KXOet7eNJhLYNRJvpk=
=7IFW
-----END PGP SIGNATURE-----
