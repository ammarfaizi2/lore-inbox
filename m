Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUI1Viu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUI1Viu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUI1Vit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:38:49 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:7902 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268024AbUI1ViK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:38:10 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Suresh Grandhi <Sureshg@ami.com>
Subject: Re: IDE Hotswap
Date: Tue, 28 Sep 2004 23:38:10 +0200
User-Agent: KMail/1.6.2
Cc: "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
In-Reply-To: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409282338.10456.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 28 September 2004 20:49, Suresh Grandhi wrote:
> Hi,
> My hardware has IDE hotswap support. I like to implement the hotswap driver
> over 2.6.8 kernel.
> Right now I am able to register and unregister the IDE devices successfully
> if they are not part of any raid or LVM.
> If I/O operation is going on the disk, then IDE unregister fails generating
> lot of I/O error messages.
> In this case, I want to make a work-around. 
> Instead of unregistering the IDE device, is there a way to re-register the
> IDE device with the already existing ports and irq when the disk is
> inserted?

No and such workaround won't work anyway because
re-register operation is nothing else but unregister+register.

hotswap is currently unsupported, some TODO items:
- convert IDE driver to use dynamic objects instead of static ones
- add needed refcounting and locking
- convert IDE driver to new driver-model
- add full sysfs support
- add hotswap

Any help/support is appreciated.

Regards,
Bartlomiej
