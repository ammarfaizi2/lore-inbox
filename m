Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTJNAQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 20:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJNAQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 20:16:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24287 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261433AbTJNAQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 20:16:21 -0400
Message-ID: <3F8B4048.2010007@pobox.com>
Date: Mon, 13 Oct 2003 20:16:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
References: <20031013140858.GU1107@suse.de> <20031013223911.GB14152@merlin.emma.line.org>
In-Reply-To: <20031013223911.GB14152@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Mon, 13 Oct 2003, Jens Axboe wrote:
> 
> 
>>Forward ported and tested today (with the dummy ext3 patch included),
>>works for me. Some todo's left, but I thought I'd send it out to gauge
>>interest. TODO:
>>
>>- Detect write cache setting and only issue SYNC_CACHE if write cache is
>>  enabled (not a biggy, all drives ship with it enabled)
> 
> 
> Yup, and I disable it on all drives at boot time at the latest.
> 
> Is there a status document that lists
> 
> - what SCSI drivers support write barriers
>   (I'm interested in sym53c8xx_2 if that matters)
> 
> - what IDE drivers support write barriers
>   (VIA for AMD and Intel for PII/PIII/P4 chip sets here)

The device is the entity that does, or does not, support flush-cache... 
  All IDE chipsets support flush-cache... it's just another IDE command.

	Jeff



