Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUINMSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUINMSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269344AbUINMPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:15:02 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:47303 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269129AbUINMOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:14:02 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Kiko Piris <kernel@pirispons.net>
Subject: Re: [2.6.8-rc1] lost DMA on my Intel 82801EB (ICH5) Serial ATA 150 Storage Controller
Date: Tue, 14 Sep 2004 14:12:35 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040914063537.GA3954@fpirisp.portsdebalears.com>
In-Reply-To: <20040914063537.GA3954@fpirisp.portsdebalears.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141412.35827.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


always cc: linux-ide@vger.kernel.org on ATA stuff

you need CONFIG_BLK_DEV_IDE_SATA

ping Jeff Garzik to make it more verbose
(ie. add runtime warning)

On Tuesday 14 September 2004 08:35, Kiko Piris wrote:
> Hi,
> 
> Since 2.6.8-rc1, DMA does not work for me. I've tried (almost) all
> kernels since that one: 2.6.8-rc[1234], 2.6.8.1 and 2.6.9-rc2.
> 
> With all of them I get the same result:
> 
> A hdparm -d tells me that DMA is off (and in fact, it is off as I can
> see from the numbers of a hdparm -t).
> 
> And if I try to activate it with hdparm -d1, it gives me a "operation
> not supported" error.
> 
> The last one that I've ben able to make DMA work is 2.6.7.
> 
> Attached is the output of:
> 
> * lspci -v
> * hdparm -I /dev/hda
> * /proc/cpuinfo
> * cat /boot/config-2.6.9-rc2 | grep -i ^config
> * dmesg (right after booting both 2.6.7 and 2.6.9-rc2)
> 
> Am I doing something wrong? Do I need to provide more information?
> 
> Many thanks in advance.
> 
