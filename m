Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTILRMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTILRMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:12:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:56836 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261744AbTILRMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:12:51 -0400
To: Sancho Dauskardt <sda@bdit.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: FAT statfs loop abort on read-error
References: <5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
	<20030706102410.2becd137.rddunlap@osdl.org>
	<5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
	<20030706102410.2becd137.rddunlap@osdl.org>
	<5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
	<5.0.2.1.2.20030911222745.02e59ec0@pop.kundenserver.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 13 Sep 2003 02:12:03 +0900
In-Reply-To: <5.0.2.1.2.20030911222745.02e59ec0@pop.kundenserver.de>
Message-ID: <871xum3p98.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sancho Dauskardt <sda@bdit.de> writes:

> Hi,
> 
>   It's a while back, but now here's a patch that "works for me".
> Once applied, we get a nice -EIO when doing a df / statfs() on a
> mounted FAT partition with removed media (without this would hang for
> minutes).
> 
> The change will affect anybody calling fat_access() (the cvf stuff,
> other fat-dependent modules).

Yes, it looks like broken the fat_cvf API. So we should remove the
fat_cvf stuff, and it should return the real error code.

Even fat was broken. (fat_read_root etc. was not addressed)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
