Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266584AbUG0S6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUG0S6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUG0S5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:57:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38812 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266558AbUG0Szp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:55:45 -0400
Message-ID: <4106A520.1070604@pobox.com>
Date: Tue, 27 Jul 2004 14:55:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.8-rc2] sata_nv.c
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95F4@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F95F4@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> Jeff Garzik wrote:
> 
> 
>>Please fix and resubmit:
>>4) [leak] driver appears to be missing a ->host_free hook, to 
>>free your 
>>nv_host_t structure.
>>
>>+       host = kmalloc(sizeof(nv_host_t), GFP_KERNEL);
> 
> 
> I register a host_stop routine, nv_host_stop(), that frees the host.  Is
> this not the correct way to free the nv_host?

I missed the kfree(), sorry.

	Jeff



