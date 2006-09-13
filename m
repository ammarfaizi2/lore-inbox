Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWIMTvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWIMTvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWIMTvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:51:51 -0400
Received: from khc.piap.pl ([195.187.100.11]:62347 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750991AbWIMTvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:51:50 -0400
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, Dmytro_Puhach@cz.ibm.com
Subject: Re: MSI K9N Neo: crash under heavy IDE read
References: <200609121046.24610.vda.linux@googlemail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 13 Sep 2006 21:51:48 +0200
In-Reply-To: <200609121046.24610.vda.linux@googlemail.com> (Denis Vlasenko's message of "Tue, 12 Sep 2006 10:46:24 +0200")
Message-ID: <m3irjr1r57.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Denis Vlasenko <vda.linux@googlemail.com> writes:

> I bought new Athlon46 mobo with AM2 socket and recently
> I noticed that copying large amounts of data reliably
> crashes 2.6.17.11 64-bit on it.
>
> memtest runs ok on this machine overnight.
> Machine is not overclocked.
>
> Copying movies from SATA drive to PATA drive oopses
> after few gigabytes transferred. Creating iso image
> with mkisofs (done entirely on PATA drive, no SATA attached)
> does the same.

I don't know about K9N Neo, but I have MSI K9N Ultra-2F (the same
MCP55) and have no such issues. But:
- I'm not using drivers/ide anymore (I was using 2.6.17.11 with
  Alan's libata-PATA patch and now I have ca. 2.6.18-rc6 merged
  with Jeff's pata-drivers git branch)
- I have only PATA CD-ROM (and SATA disk, Seagate ST3250823AS).
- just 1 GB of RAM.

Copied CD/DVD-ROM discs to HDD few times, no problems.

$ dd bs=$((1024*1024)) count=$((32*1024)) if=/dev/zero of=temp.tmp
32768+0 records in
32768+0 records out
34359738368 bytes (34 GB) copied, 670.17 seconds, 51.3 MB/s
$ time cat temp.tmp > /dev/null 

real    10m0.175s
user    0m3.210s
sys     1m11.240s
-- 
Krzysztof Halasa
