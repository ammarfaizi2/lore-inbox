Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVEJMBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVEJMBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVEJMBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:01:20 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:4362 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261619AbVEJMBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:01:14 -0400
To: Horms <horms@debian.org>
Cc: Carlos Rodrigues <carlos.efr@mail.telepac.pt>, 308072@bugs.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: statfs returns wrong values for 250Gb FAT fs
References: <E1DUT2T-0000fm-Nx@localhost.localdomain>
	<20050510080907.GR1998@verge.net.au>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 10 May 2005 21:00:51 +0900
In-Reply-To: <20050510080907.GR1998@verge.net.au> (horms@debian.org's message of "Tue, 10 May 2005 17:09:07 +0900")
Message-ID: <87oebjxpcc.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Horms <horms@debian.org> writes:

>>     printf("f_bsize = %ld blocks\nf_blocks = %ld blocks\nf_bfree = %ld blocks\nused = %ld blocks\n",
>>            stats.f_bsize, stats.f_blocks, stats.f_bfree, used);
>> 
>>     kib = stats.f_bsize / 1024;
>>     printf("total = %ld KiB\nfree = %ld KiB\nused = %ld KiB\n",
>>            kib * stats.f_blocks,
>>            kib * stats.f_bfree,
>>            kib * used);

Filesystem may have the corrupted free-cluster value.

I couldn't reproduce the problem on 2.6.12-rc4.

Could you try a recently dosfsck (dosfstools-2.11 or later)?
Also could you send the output of above program?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
