Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276159AbRJCMoh>; Wed, 3 Oct 2001 08:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276170AbRJCMo1>; Wed, 3 Oct 2001 08:44:27 -0400
Received: from hermes.toad.net ([162.33.130.251]:51117 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276166AbRJCMoY>;
	Wed, 3 Oct 2001 08:44:24 -0400
Subject: Re: [PATCH] PnPBIOS additional fixes
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 08:44:23 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011003124423.78EAB58B@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # uname -a
> Linux crusoe.alcove-fr 2.4.10-ac4 #2 Wed Oct 3 11:20:19 CEST 2001 i586 unknown
> # cd /proc/bus/pnp
> # ls
> boot  devices

Good ...

> # ls boot/
> 00  01  02  03  04  05  06  07  08  09  0b  0c  0d  0e
> # cat devices 
> 00	020cd041	06:01:00	0003
> 01	010cd041	05:00:00	0003
> 02	0002d041	08:01:01	0003
> 03	0000d041	08:00:01	0003
> 04	0001d041	08:02:01	0003
> 05	000bd041	08:03:01	0003
> 06	0303d041	09:00:00	0003
> 07	040cd041	0b:80:00	0003
> 08	0008d041	04:01:00	0003
> 09	030ad041	06:04:00	0003
> 0b	020cd041	05:00:00	0003
> 0c	020cd041	05:00:00	0003
> 0d	030ed041	06:05:00	0180
> 0e	130fd041	09:02:00	0088
> # cat boot/* > /dev/null
> # lspnp -b
> 00 PNP0c02 bridge controller: ISA
> 01 PNP0c01 memory controller: RAM
> 02 PNP0200 system peripheral: DMA controller
> 03 PNP0000 system peripheral: programmable interrupt controller
> 04 PNP0100 system peripheral: system timer
> 05 PNP0b00 system peripheral: real time clock
> 06 PNP0303 input device: keyboard
> 07 PNP0c04 reserved: other
> 08 PNP0800 multimedia controller: audio
> 09 PNP0a03 bridge controller: PCI
> 0b PNP0c02 memory controller: RAM
> 0c PNP0c02 memory controller: RAM
> 0d PNP0e03 bridge controller: PCMCIA
> 0e PNP0f13 input device: mouse
> # lspnp   
> 00 PNP0c02 bridge controller: ISA
> 01 PNP0c01 memory controller: RAM
> 02 PNP0200 system peripheral: DMA controller
> 03 PNP0000 system peripheral: programmable interrupt controller
> 04 PNP0100 system peripheral: system timer
> 05 PNP0b00 system peripheral: real time clock
> 06 PNP0303 input device: keyboard
> 07 PNP0c04 reserved: other
> 08 PNP0800 multimedia controller: audio
> 09 PNP0a03 bridge controller: PCI
> 0b PNP0c02 memory controller: RAM
> 0c PNP0c02 memory controller: RAM
> 0d PNP0e03 bridge controller: PCMCIA
> 0e PNP0f13 input device: mouse

Also, "lspnp -bv" should work and "lspnp -v" should fail.

Thanks for testing.
-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
