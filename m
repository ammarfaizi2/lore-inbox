Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUHRVPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUHRVPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbUHRVMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:12:40 -0400
Received: from holomorphy.com ([207.189.100.168]:31673 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267760AbUHRVLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:11:47 -0400
Date: Wed, 18 Aug 2004 14:11:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anders Saaby <as@cohaesio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom-killer 2.6.8.1
Message-ID: <20040818211142.GH11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anders Saaby <as@cohaesio.com>, linux-kernel@vger.kernel.org
References: <200408181455.42279.as@cohaesio.com> <20040818140550.GY11200@holomorphy.com> <200408181624.25131.as@cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408181624.25131.as@cohaesio.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 August 2004 16:05, William Lee Irwin III wrote:
>> Index: oom-2.6.8-rc1/mm/vmscan.c
>> ===================================================================
>> --- oom-2.6.8-rc1.orig/mm/vmscan.c	2004-07-14 06:17:13.876343912 -0700
>> +++ oom-2.6.8-rc1/mm/vmscan.c	2004-07-14 06:22:15.986416200 -0700
>> @@ -417,7 +417,8 @@
>>  				goto keep_locked;
>>  			if (!may_enter_fs)
>>  				goto keep_locked;
>> -			if (laptop_mode && !sc->may_writepage)
>> +			if (laptop_mode && !sc->may_writepage &&
>> +							!PageSwapCache(page))
>>  				goto keep_locked;
>>
>>  			/* Page is dirty, try to write it out here */

On Wed, Aug 18, 2004 at 04:24:24PM +0200, Anders Saaby wrote:
> laptop_mode is not set on this server <- :-)
> - So I guess this is not relevant for my setup?

Probably not. Please try to collect /proc/slabinfo snapshots while the
system is still functional as it degrades.


-- wli
