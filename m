Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUATO7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbUATO7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:59:13 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:56771 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S265550AbUATO7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:59:12 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
In-Reply-To: <1g4Ao-60b-25@gated-at.bofh.it>
References: <1fMNb-6UA-15@gated-at.bofh.it> <1fYEB-pz-23@gated-at.bofh.it> <1g4Ao-60b-25@gated-at.bofh.it>
Date: Tue, 20 Jan 2004 15:59:09 +0100
Message-Id: <E1AixLR-0000Hh-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 15:00:16 +0100, you wrote in linux.kernel:

>> I'd really like the ATA cdrom driver to handle different sector sizes 
>> properly. There really is no excuse for a block device driver to hardcode 
>> its blocksize if it can avoid it.
> 
> Agree, it's a bug. Pascal, care to take a stab at fixing it? You're the
> most avid ide-cd non-2kb block size user at the moment :)

There's a lot of macros related to sector sizes in ide-cd.h. I suppose
all that would need to be changed to depend on the real hardware sector
size?

I don't have any idea about block layer internals or about sending
commands to a drive.

In fact, I don't even know how to start or what uses of sector size
in ide-cd.c really need to be changed. Much less do I know where
information about hardware sector size could be gotten and how it should
be stored for use by ide-cd.

-- 
Ciao,
Pascal
