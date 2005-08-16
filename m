Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVHPXRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVHPXRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVHPXRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:17:13 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:63316 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750728AbVHPXRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:17:12 -0400
Message-ID: <430273F3.2000204@suse.com>
Date: Tue, 16 Aug 2005 19:17:07 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: jerome lacoste <jerome.lacoste@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
References: <5a2cf1f6050816031011590972@mail.gmail.com> <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Lameter wrote:
> On Tue, 16 Aug 2005, jerome lacoste wrote:
> 
>>Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
>>AX 300 SE/t mainboard.
>>
>>I remember seeing a message in the boot saying something along:
>>
>>  "cannot connect to hardware clock."
>>
>>And now I see that the time is changing too fast (about 2 seconds each second).
> 
> The timer interrupt is probably called twice for some reason and therefore 
> time runs twice as fast. Try using HPET for interrupt timing.
> 
>>I don't have visual on the boot sequence anymore (only remote access).
> 
> Use serial console or netconsole. The boot information is logged. Try 
> dmesg.

I am seeing similar results on my Acer Ferrari 4000 (Turion64 ML-37). It
does appear that time is running 2x normal time.

Booting with noapictimer cleared up the timing issues, though it did
introduce some IRQ badness.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFDAnPzLPWxlyuTD7IRAuQ+AKCoK4Bvj9YaSxK1cYzK/LQUGcj2pQCgmBKK
hGeSfGE+CvdNzqW3pN5LQq8=
=wtra
-----END PGP SIGNATURE-----
