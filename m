Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUKCKxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUKCKxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUKCKxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:53:33 -0500
Received: from dialin-212-144-166-159.arcor-ip.net ([212.144.166.159]:56751
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261537AbUKCKx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:53:26 -0500
In-Reply-To: <p737jp38qs4.fsf@verdi.suse.de>
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu.suse.lists.linux.kernel> <p737jp38qs4.fsf@verdi.suse.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-19-912901068"
Message-Id: <8A4609E0-2D86-11D9-BF00-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
Date: Wed, 3 Nov 2004 11:53:05 +0100
To: Andi Kleen <ak@suse.de>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-19-912901068
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 03.11.2004, at 06:06, Andi Kleen wrote:

>>    Replacing those panic(s) by printk make the machine boot just fine
>>    and also work (seemingly) without any problems under load.

> Can you print the two values? I've never seen such a problem.
> If it works then they must be identical, otherwise user space would
> break very quickly.

printk("%p %p %p\n", (unsigned long) &vgettimeofday, &vgettimeofday, 
VSYSCALL_ADDR(__NR_vgettimeofday));

ffffffffff600000 ffffffffff600000 ffffffffff600000

I've no idea why it still triggers. Also the next one BTW:
vtime link addr brokenIA32

The compiler is: gcc version 3.4.0 20040111 (experimental)

Servus,
       Daniel

--Apple-Mail-19-912901068
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQYi4kTBkNMiD99JrAQKpVwf/cnKQFlRGx8GX2qtvNuw2qvyr4MSudTbi
EjeUjTIKuA+6d4kwiM5N6Odg7Pb7mPezZ5afNRQ7usk9Q60ArXNvHwl/8xCkjqtt
DRd6t+vnfXLhzzeNL8BlRoIZbnK69lUnEWOhYirMMybx86WgHrK6JBRyLTUzuHtd
qs58lEmLGNEUJ9oKoas9TWAMrBKWA8eLDISK5YJHZPiXML/rWSIkw30l/684QKSp
A6l5K8nPiZOR0wFqf3AfF3k3kSY4zJxuiE4b35xlZhgQZzNzdoUSuMpCHJdRyqYj
TB4qCtEU9Zb+wbgVxhBAdSke9T+IlvHEmnRWggb1dSWWGxE/KLipXw==
=Bqev
-----END PGP SIGNATURE-----

--Apple-Mail-19-912901068--

