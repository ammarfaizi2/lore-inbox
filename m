Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965571AbWKGRTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbWKGRTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965574AbWKGRTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:19:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59624 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965571AbWKGRTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:19:22 -0500
Message-ID: <4550BF91.2020403@zytor.com>
Date: Tue, 07 Nov 2006 09:17:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: John <me@privacy.net>
CC: linux-kernel@vger.kernel.org, linux.nics@intel.com, saw@saw.sw.com.sg,
       thockin@hockin.org
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net>
In-Reply-To: <45506C9A.5010009@privacy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:
> 
> I then used ethtool to dump the contents of the EEPROMs.
> 
> # ethtool -e eth0
> Offset          Values
> ------          ------
> 0x0000          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0010          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0020          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0030          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0040          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0050          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0060          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0070          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> Either the EEPROM image on eth0 is corrupted, or ethtool is not
> able to read the contents of the EEPROM.
> 

[...]

> 
> I then used Donald Becker's program to dump the contents of all
> the EEPROMs. ( ftp://www.scyld.com/pub/diag/ )
> 
> # eepro100-diag -ee
> eepro100-diag.c:v2.13 2/28/2005 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> 
> Index #1: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xd800.
> EEPROM contents, size 64x16:
>     00: 3000 0464 e4e6 0e03 0000 0201 4701 0000  _0d__________G__
>   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
>       ...
>   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
>   0x38: 0000 0000 0000 0000 0000 0000 0000 92f7  ________________
>  The EEPROM checksum is correct.
> Intel EtherExpress Pro 10/100 EEPROM contents:
>   Station address 00:30:64:04:E6:E4.
>   Board assembly 721383-016, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>    Sleep mode is enabled.  This is not recommended.
>    Under high load the card may not respond to
>    PCI requests, and thus cause a master abort.
>    To clear sleep mode use the '-G 0 -w -w -f' options.
> 
> Index #2: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xdc00.
> EEPROM contents, size 64x16:
>     00: 3000 0464 e5e6 0e03 0000 0201 4701 0000  _0d__________G__
>   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
>       ...
>   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
>   0x38: 0000 0000 0000 0000 0000 0000 0000 91f7  ________________
>  The EEPROM checksum is correct.
> Intel EtherExpress Pro 10/100 EEPROM contents:
>   Station address 00:30:64:04:E6:E5.
>   Board assembly 721383-016, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>    Sleep mode is enabled.  This is not recommended.
>    Under high load the card may not respond to
>    PCI requests, and thus cause a master abort.
>    To clear sleep mode use the '-G 0 -w -w -f' options.
> 
> Index #3: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xe000.
> EEPROM contents, size 64x16:
>     00: 3000 0464 e6e6 0e03 0000 0201 4701 0000  _0d__________G__
>   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
>       ...
>   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
>   0x38: 0000 0000 0000 0000 0000 0000 0000 90f7  ________________
>  The EEPROM checksum is correct.
> Intel EtherExpress Pro 10/100 EEPROM contents:
>   Station address 00:30:64:04:E6:E6.
>   Board assembly 721383-016, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>    Sleep mode is enabled.  This is not recommended.
>    Under high load the card may not respond to
>    PCI requests, and thus cause a master abort.
>    To clear sleep mode use the '-G 0 -w -w -f' options.
> 
> Apparently, eepro100.ko is able to read the contents of the EEPROM on 
> eth0 and it declares the checksum correct. Is it possible that there is 
> a bug in e100.c that makes it fail to read the EEPROM on eth0?
> 

Sure as heck sounds like it.

	-hpa

