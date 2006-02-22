Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWBVQsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWBVQsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWBVQsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:48:19 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:57360 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1030216AbWBVQsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:48:18 -0500
Message-ID: <43FC95F6.8000707@suse.com>
Date: Wed, 22 Feb 2006 11:48:54 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Chan <mchan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: [PATCH] tg3: netif_carrier_off runs too early; could still be
 queued when init fails
References: <20060220194337.GA21719@locomotive.unixthugs.org> <1140540260.20584.6.camel@rh4> <20060221.133947.05470613.davem@davemloft.net> <43FB9718.4050606@suse.com> <1140559048.20584.20.camel@rh4>
In-Reply-To: <1140559048.20584.20.camel@rh4>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Chan wrote:
> On Tue, 2006-02-21 at 17:41 -0500, Jeff Mahoney wrote:
> 
>> dmesg after modprobe tg3:
>> tg3.c:v3.49 (Feb 2, 2006)
>> ACPI: PCI Interrupt 0000:0a:02.0[A] -> GSI 24 (level, low) -> IRQ 201
>> Uhhuh. NMI received for unknown reason 21 on CPU 0.
>> Dazed and confused, but trying to continue
>> Do you have a strange power saving mode enabled?
>> tg3_test_dma() Write the buffer failed -19
>> tg3: DMA engine test failed, aborting.
>>
> 
> You're getting an NMI during tg3_init_one() which means that the NIC is
> probably bad. I did a quick test on the same version of the 5701 NIC
> with the same tg3 driver and it worked fine.
> 
> Please find out if the NIC is known to be bad. Thanks.

Up until recently, this NIC was reported to work. I booted our
2.6.5-based SLES9 kernel on it. This is the kernel the machine has been
running for a while with the NIC working, and when I booted it, I got
the same DMA failure messages as with 2.6.16-rc4.

I suspect that the hardware has just recently failed, and I figured it
was a hardware problem when I saw the NMI/DMA messages, but since I
don't have physical access to the hardware, immediate removal wasn't an
option.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD/JX2LPWxlyuTD7IRAiKOAKCmFcjKzmyJEVF63hsm5zxPFVwNBACdHTR7
CghdO/WCfh4mwCaH1uwh1fc=
=Z5Ey
-----END PGP SIGNATURE-----
