Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUJ1OKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUJ1OKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUJ1OKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:10:00 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:10637 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261211AbUJ1OJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:09:58 -0400
Message-ID: <4180FDB3.8080305@g-house.de>
Date: Thu, 28 Oct 2004 16:09:55 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20041008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> On Thu, 28 Oct 2004, Christian wrote:
> 
> 
>>  [<c01fc7b8>] pci_enable_device_bars+0x28/0x40
>>  [<c01fc7ef>] pci_enable_device+0x1f/0x40
>>  [<e082729d>] snd_ensoniq_create+0x1d/0x480 [snd_ens1371]
>>  [<e08469cf>] snd_card_new+0x1cf/0x2c0 [snd]
> 
> 
> It's a bit dead-lock, because we cannot help you. It seems that
> the pci structure passed to our code is broken. The driver has had
> no changes in initialization for a long time.

so, it's a kernel problem again, not related to the alsa framework?

i see in

http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.10-rc1

[...]
<rddunlap@osdl.org>
	[PATCH] i386/io_apic init section fixups

<wli@holomorphy.com>
	[PATCH] vm: convert users of remap_page_range() under sound/ to
	use remap_pfn_range()
[...]

so i'll revert the patches and see what it gives.

thank you,
Christian
-- 
BOFH excuse #131:

telnet: Unable to connect to remote host: Connection refused
