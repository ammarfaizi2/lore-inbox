Return-Path: <linux-kernel-owner+w=401wt.eu-S1752886AbWLYTCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbWLYTCK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbWLYTCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 14:02:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:3714 "EHLO
	mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbWLYTCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 14:02:09 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: OGAWA Hirofumi <hogawa@miraclelinux.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] MMCONFIG: Fix x86_64 ioremap base_address
References: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
	<1166869244.3281.590.camel@laptopd505.fenrus.org>
	<87fyb6n86a.fsf@duaron.myhome.or.jp>
	<1167050198.3281.1635.camel@laptopd505.fenrus.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 26 Dec 2006 04:01:54 +0900
In-Reply-To: <1167050198.3281.1635.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon\, 25 Dec 2006 13\:36\:37 +0100")
Message-ID: <873b73x0il.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>> Current workaround is the following (both of linus and -mm),
>> 
>> 	if (pci_mmcfg_config_num == 1 &&
>> 		cfg->pci_segment_group_number == 0 &&
>> 		(cfg->start_bus_number | cfg->end_bus_number) == 0)
>>                 /* Assume it can access 256M range */
>> 
>> But, if the system has bus number 0 only, it's a correct table.
>> We may need to detect the broken system. blacklist?
>
> or just... not assume 256Mb but assume broken?

I see. And instead, add force enable option?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
