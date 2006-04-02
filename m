Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDBCVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDBCVa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 21:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWDBCVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 21:21:30 -0500
Received: from mail.parknet.jp ([210.171.160.80]:53512 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751204AbWDBCV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 21:21:29 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't pass offset == 0 && endbyte == 0 to do_sync_file_range()
References: <87fykx0z5n.fsf@duaron.myhome.or.jp>
	<20060401180559.450f20b2.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Apr 2006 11:21:23 +0900
In-Reply-To: <20060401180559.450f20b2.akpm@osdl.org> (Andrew Morton's message of "Sat, 1 Apr 2006 18:05:59 -0800")
Message-ID: <87lkuozpi4.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>>  +		/*
>>  +		 * wbc->start == 0 && wbc->end == 0 is a special range,
>>  +		 * so this avoids using it.
>>  +		 */
>>  +		if (endbyte > 1)
>>  +			endbyte--;		/* inclusive */
>>  +	}
>
> Yes, the problem is that the interface is busted - start=0,end=0 is
> ambiguous and ->writepages() will get it wrong.
>
> So I think it's better to fix the interface...

I agree. And I think WB_SYNC_NONE with rage would be useful.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
