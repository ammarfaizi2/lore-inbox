Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTICNh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTICNhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:37:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:52683 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262198AbTICNg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:36:56 -0400
Subject: Re: corruption with A7A266+200GB disk?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: steveb@unix.lancs.ac.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309030255.28645.bzolnier@elka.pw.edu.pl>
References: <E19uBCi-00054b-00@wing0.lancs.ac.uk>
	 <200309030255.28645.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062596153.19059.42.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 14:35:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 01:55, Bartlomiej Zolnierkiewicz wrote:
> If you are ready to take a risk (again ;-) ) you can remove
> "hwif->no_lba48 = ..." line from a drivers/ide/pci/alim15x3.c,
> recompile and retest without using DMA (add "ide=nodma"
> boot option).  Maybe LBA48 will work in PIO mode.

ALi does support LBA48 in PIO mode. Right now the choice is 
DMA and 137Gb or no DMA and 200Gb, ideally it should be DMA
and fall back to PIO for the top 70Gb, but not yet a while.

I've actually not yet found a controller in my testing that cannot
manage LBA48 PIO, including nailing a 160Gb drive to a Cyrix box with
a VIA VP2.


