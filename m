Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVADJmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVADJmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVADJmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:42:51 -0500
Received: from terminus.zytor.com ([209.128.68.124]:32444 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261581AbVADJmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:42:49 -0500
Message-ID: <41DA64D5.8080606@zytor.com>
Date: Tue, 04 Jan 2005 09:41:41 +0000
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
References: <41D9B1C4.5050507@zytor.com> <87d5wlmw2a.fsf@devron.myhome.or.jp>
In-Reply-To: <87d5wlmw2a.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:

> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>-	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
>>-	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
>>+	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000U;
> 
> Actually, the ->ctime_ms is not mili seconds. The valid range is 0-199 (*10ms).
> (And ->ctime is started from 2 seconds)
> 

D'oh!  They probably should be renamed _cs (centiseconds ;)

> 
>>-		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
>>+		raw_entry->ctime_ms = inode->i_ctime.tv_nsec / 1000000U;
> 
> 
> BTW, do you already have any plan to use this ioctls?
> 

Yes, I wanted to use them for the syslinux installer.

	-hpa

