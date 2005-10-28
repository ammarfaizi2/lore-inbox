Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVJ1PHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVJ1PHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbVJ1PHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:07:54 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:10500 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1030209AbVJ1PHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:07:53 -0400
To: Horms <horms@verge.net.au>
Cc: 333776@bugs.debian.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly case-insensitive
References: <20051013165529.GA2472@tennyson.dodds.net>
	<20051014023216.GJ8848@verge.net.au>
	<20051015003549.GB11040@tennyson.dodds.net>
	<20051028082252.GC11045@verge.net.au>
	<874q71wv2b.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 29 Oct 2005 00:07:40 +0900
In-Reply-To: <874q71wv2b.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Fri, 28 Oct 2005 23:54:52 +0900")
Message-ID: <87zmotvfwj.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Horms <horms@verge.net.au> writes:
>
>> static struct nls_table table = {
>>         .charset        = "utf8",
>>         .uni2char       = uni2char,
>>         .char2uni       = char2uni,
>>         .charset2lower  = identity,     /* no conversion */
>>         .charset2upper  = identity,
>>         .owner          = THIS_MODULE,
>> };
>>
>> I guess it is charset2lower or charset2upper that vfat is calling,
>> which make no conversion, thus leading to the problem I outlined above.
>>
>> My question is: Is this behaviour correct, or is it a bug?
>
> This is known bug. For fixing this bug cleanly, we will need to much
> change the both of nls and filesystems.

And fatfs has "utf8" option, probably the behavior is preferable than
"iocharset=utf8".  However, unfortunately "utf8" has problem too.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
