Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUGBRCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUGBRCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUGBRCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:02:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264746AbUGBRCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:02:22 -0400
Message-ID: <40E5950F.2090308@pobox.com>
Date: Fri, 02 Jul 2004 13:02:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       cova@ferrara.linux.it, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about SATA and IDE DVD/CD drives.
References: <Pine.LNX.4.44.0407021745400.2190-100000@einstein.homenet>
In-Reply-To: <Pine.LNX.4.44.0407021745400.2190-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> On Fri, 2 Jul 2004, Jeff Garzik wrote:
> 
>>Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
>>fix things I bet.
> 
> 
> Tried this as well on the latest snapshot (2.6.7-bk9) and it failed as 
> well. Namely, SATA disk works fine but IDE subsystem doesn't see the DVD 
> drive.
> 
> Are you sure that I only need to enable CONFIG_IDE and not some of the
> other IDE options (disk, cdrom, chipset-specific etc)?

Sorry, I was summarizing...  you definitely need a "personality" driver 
such as the ide-cdrom driver in order to make use of your DVD drive.

Really, though, I need to get off my butt and finish ATAPI in libata. 
Then, libata can drive PATA devices and we can get rid of all these 
headaches with combined mode being split between two drivers.

I'm going to be doing some libata hacking this weekend, looking 
particularly at a regression not caused by ACPI (hi Fabio).  I'll see if 
I can finish up ATAPI at that time.

	Jeff


