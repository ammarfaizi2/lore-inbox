Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUENDra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUENDra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 23:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUENDra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 23:47:30 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:34711 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S263815AbUENDr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 23:47:26 -0400
Message-ID: <40A44142.6000206@tequila.co.jp>
Date: Fri, 14 May 2004 12:47:14 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
References: <20040513032736.40651f8e.akpm@osdl.org>	<6usme4v66s.fsf@zork.zork.net>	<20040513135308.GA2622@redhat.com>	<20040513155841.6022e7b0.ak@suse.de>	<6ulljwtoge.fsf@zork.zork.net> <20040513174110.5b397d84.ak@suse.de>
In-Reply-To: <20040513174110.5b397d84.ak@suse.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
| On Thu, 13 May 2004 15:02:25 +0100
| Sean Neakums <sneakums@zork.net> wrote:
|
|>0000:00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics
Memory Controller Hub] (rev 03)

I have exact the same problem here, my i810 fails to init. I used exact
the same config like 2.6.6-mm1 which works fine.

X fails with: no /dev/agpgart

and in dmesg I find this:

i810fb: cannot acquire agp
...
Linux agpgart interface v0.100 (c) Dave Jones
[drm:i810_probe] *ERROR* Cannot initialize the agpgart module.

lspci:

0000:00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics
Memory Controller Hub] (rev 03)
0000:00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC
[Chipset Graphics Controller] (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface
to PCI Bridge (rev 05)
0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97
Audio (rev 05)
0000:01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM
Ethernet Controller (rev 03)

lspci -n

0000:00:00.0 Class 0600: 8086:7124 (rev 03)
0000:00:01.0 Class 0300: 8086:7125 (rev 03)
0000:00:1e.0 Class 0604: 8086:244e (rev 05)
0000:00:1f.0 Class 0601: 8086:2440 (rev 05)
0000:00:1f.1 Class 0101: 8086:244b (rev 05)
0000:00:1f.2 Class 0c03: 8086:2442 (rev 05)
0000:00:1f.3 Class 0c05: 8086:2443 (rev 05)
0000:00:1f.4 Class 0c03: 8086:2444 (rev 05)
0000:00:1f.5 Class 0401: 8086:2445 (rev 05)
0000:01:08.0 Class 0200: 8086:2449 (rev 03)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFApEFBjBz/yQjBxz8RAtcyAKDjbuJMwyAFktes/KnCfbpPW3rt3QCcDM5a
DMrSA1kamtEp9i+4S5rQUyM=
=MAJF
-----END PGP SIGNATURE-----
