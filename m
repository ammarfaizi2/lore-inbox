Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUKHUct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUKHUct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKHUcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:32:48 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:32215 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261213AbUKHUcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:32:36 -0500
Message-ID: <418FD7BD.2060403@g-house.de>
Date: Mon, 08 Nov 2004 21:31:57 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
CC: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net,
       linux-sound@vger.kernel.org
Subject: Re: Oops in 2.6.10-rc1
References: <418D7959.4020206@g-house.de> <20041107130553.M49691@g-house.de>	 <418E4705.5020001@g-house.de>	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>	 <418F6E33.8080808@g-house.de>	 <84144f0204110810444400761f@mail.gmail.com>	 <20041108190040.GC27386@kroah.com> <84144f02041108111816dc0b3a@mail.gmail.com>
In-Reply-To: <84144f02041108111816dc0b3a@mail.gmail.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pekka Enberg schrieb:
> Hi,
> 
> On Mon, 8 Nov 2004 11:00:40 -0800, Greg KH <greg@kroah.com> wrote:
> 
>>But 2.6.10-rc1-bk15 does have the problem?
>>
>>Trying to figure out where the issue is...

i could use the -bk snapshots too, but since i am using bk myself (i try),
i think we can narrow it down a bit more.

> 
> No, -bk14 is just the kernel I am running right now (I haven't tried
> -bk15) and I haven't had the problem. I cannot reproduce the oops _at
> all_ which is why I suspect it's his hardware. I included my lspci and
> dmesg output because we have similar (but not exactly the same)
> setups.

i've put an lspci output here:
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/lspci-v.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/lspci-vv.txt

i do not suspect hw problems *yet*, because kernel up to 2.6.9 (tracking
bk) do not show this behaviour.

> FWIW, I've asked Christian for an obdump of the kernel to see if I can

will show up in a couple of minutes here:
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/objdump-d_a1.2463.txt.bz2

this is from the vmlinux from a "bk undo -a1.2463" kernel, IOW it still
contains:

ChangeSet@1.2463, 2004-11-04 17:07:16-08:00, torvalds@ppc970.osdl.org
  Merge bk://kernel.bkbits.net/gregkh/linux/driver-2.6
  into ppc970.osdl.org:/home/torvalds/v2.6/linux


thank you for the hints,
Christian.

PS: should we i un'CC linux-sound and alsa-devel, now we are sure it's a
pci thing?
- --
BOFH excuse #228:

That function is not currently supported, but Bill Gates assures us it
will be featured in the next upgrade.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBj9e9+A7rjkF8z0wRAregAJ9TyK5Mt00CFmCcgA1pOKmzvIxv2QCg0OBi
/9eNZ41Kp2GAOg4J5l0QR8E=
=OkFI
-----END PGP SIGNATURE-----
