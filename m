Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVH3T2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVH3T2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVH3T2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:28:11 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54283 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932383AbVH3T2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:28:09 -0400
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #2
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 31 Aug 2005 04:27:52 +0900
In-Reply-To: <4313E578.8070100@sm.sony.co.jp> (Hiroyuki Machida's message of "Tue, 30 Aug 2005 13:50:00 +0900")
Message-ID: <874q979qdj.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:

> Here is a revised version of dirent scan patch,  mentioned at
> following E-mail.
>
> This patch addresses performance damages on "ls | xargs xxx" and
> reverse order scan which are reported to the previous patch.
>
> With this patch, fat_search_long() and fat_scan() use hint value
> as start of scan. For each directory holds multiple hint value entries.
> The entry would be selected by hash value based on scan target name and
> PID. Hint value would be calculated based on the entry previously found
> entry, so that the hint can cover backward neighborhood.

This patch couldn't compile. I assume you post a wrong patch...?

The code is strange... Is the hint value related to the previously
accessed entry?

This seems to be randomly cacheing the recent access position...  Is
it your intention of this patch?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
