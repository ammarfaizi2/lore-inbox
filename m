Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVARCaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVARCaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVARCaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:30:14 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18960 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261174AbVARCaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:30:09 -0500
To: =?iso-8859-1?q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/13] FAT: Return better error codes from
 vfat_valid_longname()
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<20050118020324.GC11257@ime.usp.br>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 11:29:50 +0900
In-Reply-To: <20050118020324.GC11257@ime.usp.br> (
 =?iso-8859-1?q?Rog=E9rio_Brito's_message_of?= "Tue, 18 Jan 2005 00:03:25
 -0200")
Message-ID: <878y6rlba9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> writes:

> On Jan 18 2005, OGAWA Hirofumi wrote:
>>  static int vfat_valid_longname(const unsigned char *name, unsigned int len)
>>  {
>> -	if (len && name[len-1] == ' ')
>> -		return 0;
>> +	if (name[len - 1] == ' ')
>> +		return -EINVAL;
>
> Sorry for the stupid question, but is len guaranteed to be always greater
> than zero?

Yes. That "len" was already checked in vfat_add_entry().

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
