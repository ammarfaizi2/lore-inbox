Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUFCGMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUFCGMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUFCGMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:12:00 -0400
Received: from zasran.com ([198.144.206.234]:45986 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263923AbUFCGLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:11:45 -0400
Message-ID: <40BEC11F.8070605@bigfoot.com>
Date: Wed, 02 Jun 2004 23:11:43 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6] ICH5 SATA problems
References: <200406030642.16890.lkml@kcore.org>
In-Reply-To: <200406030642.16890.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> Hello List,
> 
> A friend of mine is trying to get both SATA and PATA working together on his Siemens box. The bios has a bunch of settings
> concering sata/pata, being:
> - SATA Standard (which is bootable by the bios). When this is selected, another setting is available
> 	* Sata 1/2 only
> 	* sata 1/2 + pata 3/4
> 	* pata 1/2 + sata 1/2

   which kernel are you using and what are the sata related settings?

   I have intel D865PERL with same sata controller as your friend, using 
kernel 2.6.5, sata configured as scsi:

CONFIG_SCSI=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_ATA_PIIX=y

   I have both ide (/dev/hd[a-d]) and sata disks (/dev/sda1), all 
visible (two HDs on first ide controller, cd burner and dvd on second 
ide controller, HD on SATA)

   with 2.4.x kernels you might need some patches, the first 2.4.x 
kernel  I know supports SATA is 2.4.21-ac4, plus you (your friend) need 
libata5 patches for SATA disks over 137GB.

	erik
