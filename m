Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbUK3U0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbUK3U0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbUK3U0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:26:04 -0500
Received: from alog0424.analogic.com ([208.224.222.200]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262290AbUK3U0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:26:00 -0500
Date: Tue, 30 Nov 2004 15:25:40 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Walking all the physical memory in an x86 system
In-Reply-To: <1101840619.25609.107.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0411301519130.4393@chaos.analogic.com>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406> 
 <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr>  <41ACADD3.2030206@draigBrady.com>
  <Pine.LNX.4.53.0411301832510.11795@yvahk01.tjqt.qr>
 <1101840619.25609.107.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Alan Cox wrote:

> On Maw, 2004-11-30 at 17:34, Jan Engelhardt wrote:
>> 	unsigned short p;
>> 	fd = open("/dev/mem", O_RDONLY | O_BINARY);
>> 	lseek(fd, 0x400, SEEK_SET);
>> 	read(fd, &p, 2);
>
> You want ports for that not mem, has always been the case since back
> before Linux existed.
>

At offset 0 in the BIOS segment of 0x40, real address 0x400, are
the addresses of up to 4 ports for the serial communications
devices, followed by up to 4 port addresses of any parallel
communications devices found by the BIOS upon startup. This
is likely what he meant. The code shown will return the address
of the first RS-232 device (usually a 8250 UART) found.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
