Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUBFJni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBFJni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:43:38 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33555 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265365AbUBFJng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:43:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Michael Frank <mhf@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 HIGHMEM=300m: BUG: wrong zone alignment, it will crash
Date: Fri, 6 Feb 2004 11:39:33 +0200
X-Mailer: KMail [version 1.4]
References: <200402061121.34174.mhf@linuxmail.org>
In-Reply-To: <200402061121.34174.mhf@linuxmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402061139.33076.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 February 2004 05:21, Michael Frank wrote:
> System has 500M RAM. When using highmem=300m dmesg as follows.

500m total or 500m over 4g?

> Linux version 2.4.24-mhf168 (root@mhfl4) (gcc version 2.95.3 20010315
> (release)) #2 Fri Feb 6 11:08:28 HKT 2004 BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

low 640k

>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)

almost up to 512m mark only. So, you dont have any highmem.

>  BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
>  BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> 300MB HIGHMEM available.

you lied to kernel

> 195MB LOWMEM available.
> On node 0 totalpages: 126960
> zone(0): 4096 pages.
> zone(1): 46064 pages.
> zone(2): 76800 pages.
> BUG: wrong zone alignment, it will crash
> Kernel command line: vga=0xf07 root=/dev/hda4 resume2=swap:/dev/hda1
> console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off
> highmem=300m
  ^^^^^^^^^^^^ wrong
>
> What went wrong ?
-- 
vda
