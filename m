Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVELC7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVELC7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVELC7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:59:18 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21388 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261212AbVELC7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:59:14 -0400
Message-ID: <4282C681.6030908@acm.org>
Date: Wed, 11 May 2005 21:59:13 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: acpi=off and acpi_get_firmware_table
References: <42823F15.7090601@acm.org> <1115866445.8814.1.camel@linux-hp.sh.intel.com>
In-Reply-To: <1115866445.8814.1.camel@linux-hp.sh.intel.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:

>On Wed, 2005-05-11 at 12:21 -0500, Corey Minyard wrote:
>  
>
>>In 2.6.12-rc4, I added acpi=off to the kernel command line and it 
>>panic-ed in acpi_get_firmware_table, called from the IPMI driver.
>>
>>The attached patch fixes the problem, but it still spits out ugly 
>>"ACPI-0166: *** Error: Invalid address flags 8" errors.  So I doubt the 
>>patch is right, but maybe it points to something else.
>>
>>Is it legal to call acpi_get_firmware_table if acpi is off?  If not, how 
>>can I tell that acpi is off?
>>    
>>
>Please check 'acpi_disabled' variable.
>  
>
acpi_disabled is not available on ia64.  It doesn't seem to be a 
standard interface.  So that's not an option.

-Corey
