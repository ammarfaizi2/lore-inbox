Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVJVKpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVJVKpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 06:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVJVKpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 06:45:52 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54794 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932217AbVJVKpv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 06:45:51 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT,RFC] FAT: Add "flush" option for hotplug devices
References: <871x2gf8f5.fsf@devron.myhome.or.jp>
	<20051022101552.GA2403@infradead.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Oct 2005 19:45:31 +0900
In-Reply-To: <20051022101552.GA2403@infradead.org> (Christoph Hellwig's message of "Sat, 22 Oct 2005 11:15:52 +0100")
Message-ID: <87hdb9de44.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +++ linux-2.6.14-rc4-hirofumi/fs/fat/flush.c	2005-10-21 00:25:22.000000000 +0900
>> @@ -0,0 +1,90 @@
>> +/*
>> + * Copyright (C) 2005, OGAWA Hirofumi
>> + * Released under GPL v2.
>> 
> Except for placing the flush time in the msdosfs SB there is nothing
> filesystem-specific in this file.  Please place it in generic code,
> that way there's no reason to export all these deeply internal
> symbols either.

OK, except filemap_write_and_wait().

Many filesystems does

	filemap_fdatawrite(mapping);
	filemap_fdatawait(mapping);

Don't you want filemap_write_and_wait()?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
