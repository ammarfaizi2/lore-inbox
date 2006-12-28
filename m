Return-Path: <linux-kernel-owner+w=401wt.eu-S932763AbWL1JgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWL1JgL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbWL1JgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:36:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:37417 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932763AbWL1JgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:36:10 -0500
Message-ID: <45939008.106@qumranet.com>
Date: Thu, 28 Dec 2006 11:36:08 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS - KVM in 2.6.20-rc2
References: <122820060049.5177.4593147E000B4D2C0000143922007621949D0E050B9A9D0E99@comcast.net>
In-Reply-To: <122820060049.5177.4593147E000B4D2C0000143922007621949D0E050B9A9D0E99@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> Running qemu with 512M ram out of available 480M total invoked the OOM killer (that's obvious along with other OOM-killer stupidities like killing totally irrelevant processes) followed by the below OOPS.
>
> Killed process 19271 (trashapplet)Out of memory: kill process 12475 (qemu) score 7899 or a childOut of memory: kill process 12475 (qemu) score 7899 or a childKilled process 12475 (qemu)Killed process 12475 (qemu)
>
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004 printing eip:c0153aa2*pde = 17339067*pte = 

I've committed a fix for this, and will send it to Andrew shortly.  
Thanks for the report.

-- 
error compiling committee.c: too many arguments to function

