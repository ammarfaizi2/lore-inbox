Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310691AbSBRO5T>; Mon, 18 Feb 2002 09:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310694AbSBRO5K>; Mon, 18 Feb 2002 09:57:10 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:22800 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S310691AbSBRO45>; Mon, 18 Feb 2002 09:56:57 -0500
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT
In-Reply-To: <20020218134640.Y24227-100000@toad.stack.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 18 Feb 2002 23:56:35 +0900
In-Reply-To: <20020218134640.Y24227-100000@toad.stack.nl>
Message-ID: <874rken8ik.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink <josh@stack.nl> writes:

> Hi Ogawa,
> 
> Your patch seems to fix it more or less, not the way it should be
> fixed, imho.  Partitions other than FAT return bogus information, but
> bogus is not always zero. Fortunately enough, one of those new if
> statements returns an error, but this is a "works for me"
> solution, not a decent one.

No, that patch are validity check for FAT, not for you.

> What lacks is a fingerprint detector, and iirc -long time ago- FAT has a
> very easy to detect fingerprint.
> 
> I'll dig into FAT documentation tonight.

I read the document repeatedly and did much tests. If you read the
document, you may use BS_OEMName or BS_FilSysType, however, these
don't have a meaning.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
