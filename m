Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUI3JZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUI3JZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 05:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUI3JZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 05:25:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:11659 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268317AbUI3JZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 05:25:06 -0400
X-Authenticated: #4512188
Message-ID: <415BD123.8020608@gmx.de>
Date: Thu, 30 Sep 2004 11:25:55 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040929)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: white phoenix <white.phoenix@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nforce2 bugs?
References: <e2ae0e3b04092915427fcff604@mail.gmail.com> <1096496263.16768.12.camel@localhost.localdomain>
In-Reply-To: <1096496263.16768.12.camel@localhost.localdomain>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox schrieb:
| On Mer, 2004-09-29 at 23:42, white phoenix wrote:
|
|>[x86] fix lockups with APIC support on nForce2
|
|
| Looks reasonable (anyone from Nvidia care to ack any of these)

As far as I could see, none of the posted patches are needed, or rather
the correct one(s) is already included in the kernel. The older ones
were workarounds, not needed anymore, thus obsolete.

The only problem is the apic timer thing. It just gets activated if the
correct BIOS Version is found (see the dmi scan thingie). So I just pass
acpi_skip_timer_override to the kernel to be sure.

|>Add PCI quirk to disable Halt Disconnect and Stop Grant Disconnect
|>(based on athcool program by Osamu Kayasono).
|
|
| Is this always safe - if not why does the BIOS not do it.

It is safe but makes your CPU hotter. Thus the real fix just changes the
disconnect intervall (or alike). Look into arch/i386/pci/fixup.h and
search for nforce2.

Prakash

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBW9EjxU2n/+9+t5gRAhKPAKDHnBuJs9bN4ZeQwCa9r4hu3woTcgCfbWmB
4yz7q8RBHXeodlkrpwYUH8w=
=Ipiu
-----END PGP SIGNATURE-----
