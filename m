Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUJGVsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUJGVsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUJGVqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:46:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25275 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267555AbUJGVo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:44:59 -0400
Message-ID: <4165B8CC.7010700@pobox.com>
Date: Thu, 07 Oct 2004 17:44:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca>
In-Reply-To: <4165B233.9080405@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> On a related note..
> 
> In the longer term, I'd like Jeff & I to get together and agree
> upon some interface changes in libata to make it easier for this
> driver (and others) to share more of the code dealing with
> the emulation of non-data SCSI commands like INQUIRY and friends.
> 
> Right now that's not as easy as it could be, due to the specialized
> libata struct parameters required, but I think it could be harmonized.

libata exists as it does simply due to how it evolved.

Please just submit patches containing the changes you want, I'm very 
receptive to improvements that increase the breadth of libata's coverage.

As the name implies, libata is just a library of code and nothing more. 
  A driver could choose to use the to/from FIS functions and none of the 
driver architecture, for example.  libata exists solely to concentrate 
ATA code into a single location.

(similarly, include/linux/ata.h exists to concentrate all ATA-related 
defines in one location)

	Jeff



