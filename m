Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWEBQYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWEBQYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEBQYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:24:52 -0400
Received: from fmr19.intel.com ([134.134.136.18]:42409 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964791AbWEBQYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:24:51 -0400
Message-ID: <4457877F.5000406@linux.intel.com>
Date: Tue, 02 May 2006 18:23:27 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as unused-for-removal-soon
References: <1146581587.32045.41.camel@laptopd505.fenrus.org> <20060502092440.91fe8797.rdunlap@xenotime.net>
In-Reply-To: <20060502092440.91fe8797.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 02 May 2006 16:53:07 +0200 Arjan van de Ven wrote:
> 
>> Hi,
>> As discussed on lkml before; the patch with the infrastructure to deprecate unused symbols
>>
>> This is patch one in a series of 17; to not overload lkml the other 16 will be mailed direct;
>> people who want to see them all can see them at http://www.fenrus.org/unused
>>
>>
>>
>> This patch temporarily adds EXPORT_UNUSED_SYMBOL and EXPORT_UNUSED_SYMBOL_GPL.
>> These will be used as transition measure for symbols that aren't used in the 
>> kernel and are on the way out. When a module uses such a symbol, a warning
>> is printk'd at modprobe time.
>>
>> The main reason for removing unused exports is size: eacho export takes roughly
>> between 100 and 150 bytes of kernel space in the binary. This patch gives
>> users the option to immediately get this size gain via a config option.
> 
> Do the exports take any space at runtime in RAM?

yes; roughly 100 to 150 bytes or so

> scsi patch comments (only one that I have seen) say:
> +EXPORT_UNUSED_SYMBOL(scsi_print_status); /* removal in 2.6.19 */
> 
> and When: above says "before 2.6.19".  Those don't agree.
> Please fix.  Thanks.

there's no conflict actually; they'll be gone in 2.6.19, by removing them just before that ;)
