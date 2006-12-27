Return-Path: <linux-kernel-owner+w=401wt.eu-S932975AbWL0Ptq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbWL0Ptq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932983AbWL0Ptq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:49:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:8852 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbWL0Ptp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:49:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A6WGJjl8/ZSVPTFtl8rujUYyEV8P5CyEheop8NXVctu+unp20v4MLozU8w/ldc7C0tag3/foLIQBTvhnkt0h8PnWG+v5XaSKJgZl2jPy116XrvdlqBVSVNAG6V7MX41OGA48RWoYiA17lLIf/krtDR+Q9xDcNieNTsQ8Mq1K1i0=
Message-ID: <6d6a94c50612270749j77cd53a9mba6280e4129d9d5a@mail.gmail.com>
Date: Wed, 27 Dec 2006 23:49:43 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Page alignment issue
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As for the buddy system, much of docs mention the physical address of
the first page frame of a block should be a multiple of the group
size. For example, the initial address of a 16-page-frame block should
be 16-page aligned. I happened to encounted an issue that the physical
addresss pf the block is not 4-page aligned(0x36c9000) while the order
of the block is 2. I want to know what out of buddy algorithm depend
on this feature? My problem seems to happen in
schedule()->context_switch() call, but so far I didn't figure out the
root cause.

Any clue or suggestion will be really appreciated!
Thanks,
-Aubrey
