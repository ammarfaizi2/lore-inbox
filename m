Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVBXABk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVBXABk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBWX7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:59:23 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:11193 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261717AbVBWX4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:56:10 -0500
Message-ID: <421D1811.3060705@ens-lyon.org>
Date: Thu, 24 Feb 2005 00:56:01 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
References: <20050223014233.6710fd73.akpm@osdl.org> <421CC959.3070405@ens-lyon.org> <20050223212433.GA31281@isilmar.linta.de>
In-Reply-To: <20050223212433.GA31281@isilmar.linta.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski a écrit :
>>>+pcmcia-bridge-resource-management-fix.patch
> 
> is responsible for this "no resource available" message, because the other
> ones relate to other areas.

This line from dmesg-2.6.11-rc4 is no longer present in -rc4-mm1:
PCI: Transparent bridge - 0000:00:1e.0

This is probably due to this patch too, right ?
Was it supposed to changed that ?

lspci -tv says that the PCMCIA bridge whose resources are broken
is behind this no-longer transparent bridge.

-[00]-+-00.0  Intel Corp. 82830 830 Chipset Host Bridge
       +-01.0-[01]----00.0  ATI Technologies Inc Radeon Mobility M6 LY
       +-1d.0  Intel Corp. 82801CA/CAM USB (Hub #1)
       +-1d.1  Intel Corp. 82801CA/CAM USB (Hub #2)
       +-1d.2  Intel Corp. 82801CA/CAM USB (Hub #3)
       +-1e.0-[02-04]--+-03.0  Texas Instruments PCI1420
       |               +-03.1  Texas Instruments PCI1420
       |               +-04.0  Agere Systems (former Lucent Microelectronics) LT WinModem
       |               +-08.0  Intel Corp. 82801CAM (ICH3) PRO/100 VM (KM) Ethernet Controller
       |               \-09.0  ESS Technology ES1988 Allegro-1
       +-1f.0  Intel Corp. 82801CAM ISA Bridge (LPC)
       \-1f.1  Intel Corp. 82801CAM IDE U100

Hope this helps.

Brice
