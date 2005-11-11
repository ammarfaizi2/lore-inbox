Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKKLgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKKLgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKKLgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:36:41 -0500
Received: from mail.dvmed.net ([216.237.124.58]:23176 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750756AbVKKLgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:36:40 -0500
Message-ID: <4374823C.1090704@pobox.com>
Date: Fri, 11 Nov 2005 06:36:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: axboe@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       steve.cameron@hp.com
Subject: Re: [PATCH 1/1] cciss: scsi error handling
References: <20051104183037.GA8527@beardog.cca.cpqcorp.net>
In-Reply-To: <20051104183037.GA8527@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
> PATCH 1 of 1
> 
> This patch adds SCSI error handling code to the SCSI portion 
> of the cciss driver.
> 
> Signed-off-by: Stephen M. Cameron <steve.cameron@hp.com>
> Acked-by: Mike Miller <mike.miller@hp.com>

> +#ifdef CONFIG_CISS_SCSI_TAPE

Two comments:

1) CONFIG_CISS_SCSI_TAPE should be CONFIG_CCISS_SCSI_TAPE, IMO

2) is any locking needed in your scsi eh reset handlers?  recent kernels 
eliminate the lock that's been traditionally held around the handlers.

	Jeff


