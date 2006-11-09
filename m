Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965961AbWKIMQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965961AbWKIMQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 07:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965962AbWKIMQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 07:16:44 -0500
Received: from SMT02001.global-sp.net ([193.168.50.54]:37009 "EHLO
	SMT02001.global-sp.net") by vger.kernel.org with ESMTP
	id S965961AbWKIMQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 07:16:42 -0500
Message-ID: <45531C42.3070503@privacy.net>
Date: Thu, 09 Nov 2006 13:17:06 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Auke Kok <auke-jan.h.kok@intel.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hpa@zytor.com,
       saw@saw.sw.com.sg
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net> <45520337.2070303@intel.com>
In-Reply-To: <45520337.2070303@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 12:18:43.0324 (UTC) FILETIME=[328DC3C0:01C703F9]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:

> This is what I was afraid of: even though the code allows you to bypass 
> the EEPROM checksum, the probe fails on a further check to see if the 
> MAC address is valid.
> 
> Since something with this NIC specifically made the EEPROM return all 
> 0xff's, the MAC address is automatically invalid, and thus probe fails.

I don't understand why you think there is something wrong with a
specific NIC?

In 2.6.14.7, e100.ko fails to read the EEPROM on 0000:00:08.0 (eth0)
In 2.6.18.1, e100.ko fails to read the EEPROM on 0000:00:09.0 (eth1)
In both kernels, eepro100.ko successfully reads all the EEPROMs.

> It seems that the driver has more problems with this NIC than just the 
> eeprom checksum being bad. Needless to say this might need fixing.
> 
> Can you load the eepro driver and send me the full eeprom dump?
> Perhaps I can duplicate things over here.

00:08.0 EEPROM contents, size 64x16

   3000 0464 e4e6 0e03 0000 0201 4701 0000
   7213 8310 40a2 0001 8086 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0128 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 92f7

00:09.0 EEPROM contents, size 64x16

   3000 0464 e5e6 0e03 0000 0201 4701 0000
   7213 8310 40a2 0001 8086 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0128 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 91f7

00:0a.0 EEPROM contents, size 64x16

   3000 0464 e6e6 0e03 0000 0201 4701 0000
   7213 8310 40a2 0001 8086 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0128 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 90f7
