Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264108AbUEMUr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUEMUr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUEMUr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:47:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10429 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264108AbUEMUr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:47:27 -0400
Message-ID: <40A3DED2.1070000@pobox.com>
Date: Thu, 13 May 2004 16:47:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A.Magallon" <jamagallon@able.es>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) on Linux status report
References: <20040510222506.GA21370@havoc.gtf.org> <D971D9DE-A4C4-11D8-9D2C-000A9585C204@able.es>
In-Reply-To: <D971D9DE-A4C4-11D8-9D2C-000A9585C204@able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A.Magallon wrote:
> I'm going to get an Asus PC-DL with an onboard Promise PDC20378 Serial ATA
> controller that has 2 serial ata ports and one ATA133 channel.
> The mobo also has two ATA100 ports.
> 
> Is it possible to use only the PATA from the promise ? I have no
> SATA drives now, but I could use the ATA133 port.
> Is there any PATA driver that works with the promise, even if I
> don't see or disable the SATA ports ?


The only way to use the PATA ports is to use a driver from Promise. 
libata doesn't support PDC203xx PATA ports at all, regardless of 
configuration.

Technically speaking, libata needs to be modified to support two 
different types of "host operations".  Once that internal limitation is 
removed, adding support for the PATA ports is easy.

	Jeff



