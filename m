Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRJCJZj>; Wed, 3 Oct 2001 05:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRJCJZa>; Wed, 3 Oct 2001 05:25:30 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:31495 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S272074AbRJCJZT>;
	Wed, 3 Oct 2001 05:25:19 -0400
Date: Wed, 3 Oct 2001 11:25:41 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnPBIOS additional fixes
Message-ID: <20011003112541.G574@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011003043907.DAB5658B@thanatos.toad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011003043907.DAB5658B@thanatos.toad.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 12:39:07AM -0400, Thomas Hood wrote:

> Stelian:  Here is my patch with additional fixes to the PnP BIOS driver.
> Applies against 2.4.10-ac4 (which contains your dmi scan changes).
> Could you please do me a favor and test it out?  It's nice when
> asking Alan to apply a patch to be able to tell him that at least
> two people have tested it.  :)

Works for me (at least in compiles and seems to run correctly,
not sure if you want some additionnal tests):

# uname -a
Linux crusoe.alcove-fr 2.4.10-ac4 #2 Wed Oct 3 11:20:19 CEST 2001 i586 unknown
# cd /proc/bus/pnp
# ls
boot  devices
# ls boot/
00  01  02  03  04  05  06  07  08  09  0b  0c  0d  0e
# cat devices 
00	020cd041	06:01:00	0003
01	010cd041	05:00:00	0003
02	0002d041	08:01:01	0003
03	0000d041	08:00:01	0003
04	0001d041	08:02:01	0003
05	000bd041	08:03:01	0003
06	0303d041	09:00:00	0003
07	040cd041	0b:80:00	0003
08	0008d041	04:01:00	0003
09	030ad041	06:04:00	0003
0b	020cd041	05:00:00	0003
0c	020cd041	05:00:00	0003
0d	030ed041	06:05:00	0180
0e	130fd041	09:02:00	0088
# cat boot/* > /dev/null
# lspnp -b
00 PNP0c02 bridge controller: ISA
01 PNP0c01 memory controller: RAM
02 PNP0200 system peripheral: DMA controller
03 PNP0000 system peripheral: programmable interrupt controller
04 PNP0100 system peripheral: system timer
05 PNP0b00 system peripheral: real time clock
06 PNP0303 input device: keyboard
07 PNP0c04 reserved: other
08 PNP0800 multimedia controller: audio
09 PNP0a03 bridge controller: PCI
0b PNP0c02 memory controller: RAM
0c PNP0c02 memory controller: RAM
0d PNP0e03 bridge controller: PCMCIA
0e PNP0f13 input device: mouse
# lspnp   
00 PNP0c02 bridge controller: ISA
01 PNP0c01 memory controller: RAM
02 PNP0200 system peripheral: DMA controller
03 PNP0000 system peripheral: programmable interrupt controller
04 PNP0100 system peripheral: system timer
05 PNP0b00 system peripheral: real time clock
06 PNP0303 input device: keyboard
07 PNP0c04 reserved: other
08 PNP0800 multimedia controller: audio
09 PNP0a03 bridge controller: PCI
0b PNP0c02 memory controller: RAM
0c PNP0c02 memory controller: RAM
0d PNP0e03 bridge controller: PCMCIA
0e PNP0f13 input device: mouse
# 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
