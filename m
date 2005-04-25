Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVDYLdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVDYLdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVDYLdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:33:11 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:51211 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262589AbVDYLdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:33:07 -0400
To: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Two questions related with FAT filesystem and block device layer.
References: <1114397961.793.17.camel@milo>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 25 Apr 2005 20:32:20 +0900
In-Reply-To: <1114397961.793.17.camel@milo> (Zhonglin Zhang's message of "Mon, 25 Apr 2005 10:59:21 +0800")
Message-ID: <87fyxfdrcr.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn> writes:

>  Q1.
>     When I use "mkdosfs /dev/tffsa1", WIN2000 And WINXP can
>     read/write the /dev/tffsa1. 
>     When I use "mkdosfs -S 4096 /dev/tffsa1", WIN2000
>     can read/write the /dev/tffsa1, But Winxp can't.
>
>     Why? W can I make the winxp can read/write the /dev/sda1.

I don't know.

>  Q2. 
>     When using "mkdosfs /dev/tffsa1", Our VideoRecord isn't fluent. 
>
>     When using "mkdosfs -S 4096 /dev/tffsa1", Our VideoRecord is fluent.
>     I wonder how the sector size affect the Video Record.

I guess the cluster size was increased by "-S 4096", so the number of
times of block allocation became fewer.

>  Our ultimate goal is 'Video Record is fluent and Win2000/Winxp can 
>  read/write the /dev/tffsa1 as a u-disk.

How about testing the "mkdosfs -s 64 /dev/foo"?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
