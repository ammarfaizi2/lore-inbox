Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUC0XEs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUC0XEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:04:47 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:42929 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261907AbUC0XEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:04:43 -0500
Message-ID: <40660877.3090302@stesmi.com>
Date: Sun, 28 Mar 2004 00:04:23 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com>
In-Reply-To: <4066021A.20308@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

> The "lba48" feature in ATA allows for addressing of sectors > 137GB, and 
> also allows for transfers of up to 64K sector, instead of the 
> traditional 256 sectors in older ATA.
> 
> libata simply limited all transfers to a 200 sectors (just under the 256 
> sector limit).  This was mainly being careful, and making sure I had a 
> solution that worked everywhere.  I also wanted to see how the iommu S/G 
> stuff would shake out.
> 
> Things seem to be looking pretty good, so it's now time to turn on 
> lba48-sized transfers.  Most SATA disks will be lba48 anyway, even the 
> ones smaller than 137GB, for this and other reasons.
> 
> With this simple patch, the max request size goes from 128K to 32MB... 
> so you can imagine this will definitely help performance.  Throughput 
> goes up.  Interrupts go down.  Fun for the whole family.

What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
in most SATA disks today?

Is large transfers mandatory in the LBA48 spec and is LBA48 really
mandatory in SATA?

And yes, I saw that the dmesg showed a Maxtor drive, but I'm uncertain
if that disk of yours has a Marvel chip on or not, since newer Maxtors
might (have) come out (already) without a Marvel chip, I just don't
know.

// Stefan
