Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTGATLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTGATLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:11:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17614 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263462AbTGATL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:11:26 -0400
Message-ID: <3F01E030.9060201@pobox.com>
Date: Tue, 01 Jul 2003 15:25:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ata-scsi driver update
References: <3F00CEDC.2010806@pobox.com> <1057086391.3444.3.camel@paragon.slim>
In-Reply-To: <1057086391.3444.3.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> Hi,
> 
> I've just tried your patch. Compiling fails at make dep:

> make[4]: *** No rule to make target `libata.c', needed by
> `/usr/src/linux-2.4.21/include/linux/modules/libata.ver'.  Stop.

> Under SCSI low-level drivers only ATA support and Intel PIIX/ICH support
> are selected.
> 
> This is with a freshly installed and patched 2.4.21.

hmmm.  did you run a "make mrproper" or "make distclean" before 
building?  The above is a symptom of stale dependencies, not really any 
kernel patch.

Just to be sure, though, I just tried building from a fresh 2.4.21 
tarball + my patch, with modversions enabled, and it worked.

	Jeff


