Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUCYOPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUCYOPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:15:50 -0500
Received: from 011.081.dsl.concepts.nl ([213.197.11.81]:43982 "EHLO
	server.thuis.lan") by vger.kernel.org with ESMTP id S262310AbUCYOPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:15:48 -0500
Message-ID: <4062E986.2080508@xs4all.nl>
Date: Thu, 25 Mar 2004 15:15:34 +0100
From: Rik van Ballegooijen <sleightofmind@xs4all.nl>
Reply-To: sleight@xs4all.nl
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
References: <200403251432.32787@WOLK>
In-Reply-To: <200403251432.32787@WOLK>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marc-Christian Petersen wrote:
| attached you find my .config and dmesg log booting 2.6.5-rc2-mm3 with
ACPI
| enabled. Seems something is broken in there.
|
| Booting with acpi=off "fixes" it ;>
|
| 2.6.5-rc2-mm2 worked fine.
|
| Rik, I saw you had the same experience? Please ACK it :)

with acpi on it can also run, but not if you supply vga=. I tried with
vga=0x317 and it stalls after "Freeing unused kernel memory". When i
turn off acpi using acpi=off and also supply vga=0x317 it continues
booting, but hangs during execution of bootscripts. An example of this
is a script executing /bin/setfont.
The complete append line i use is:

root=/dev/hda3 debug video=mtrr,vesa:1024x768 vga=0x317

I can send my .config and/or dmesg output on demand, but since i am not
the only one with this problem and mcp already send his i did not find
it necessary.

- -Rik
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAYumGq1cnhHKeD68RAj9QAKCyEs6msPzcJcsc/WUz+t8e2h+F7wCdHIWd
yNirw9Lq76z5liix8yfsQY4=
=V48i
-----END PGP SIGNATURE-----
