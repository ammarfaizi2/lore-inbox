Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUG0CJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUG0CJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 22:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUG0CJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 22:09:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60817 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266222AbUG0CJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 22:09:29 -0400
Message-ID: <4105B947.1000106@pobox.com>
Date: Mon, 26 Jul 2004 22:09:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andrew Chew <achew@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95EF@hqemmail02.nvidia.com> <20040726180601.3b88d166.akpm@osdl.org>
In-Reply-To: <20040726180601.3b88d166.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Andrew Chew" <achew@nvidia.com> wrote:
> 
>>I sincerely apologize about the mangled patch.  I'll be more careful
>>next time (and check my mailer settings).
> 
> 
> Is OK - you're in good company ;)
> 
> 
>>The #ifdef was for consistency (I noticed that there were other IDs
>>similarly defined in intel8x0.c).  I don't see why we'd need it, either.
>>We should probably remove PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO and
>>PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO #defines from intel8x0.c as well, as
>>they're similarly redundant.  For that matter, why not remove all of the
>>PCI_DEVICE_ID_* #defines from the intel8x0.c driver, and make sure the
>>device IDs are defined in pci_ids.h.
>>
>>Want me to submit a patch for that?
> 
> 
> Let's leave that up to Jeff.

Jaroslav and the ALSA guys...  no idea who maintains the ALSA i810 driver.

In any case, I think the device id constants are a waste, and have 
stopped using the *_DEVICE_ID_* constants in my drivers.  The vendor id 
is generally common across many drivers, but rarely does one care about 
sharing arbitrary name<->arbitrary id mappings these days, when one 
driver supports so many chips.

	Jeff



