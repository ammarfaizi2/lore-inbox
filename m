Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWDFHbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDFHbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 03:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWDFHbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 03:31:40 -0400
Received: from zeus.itg.uiuc.edu ([130.126.126.162]:49107 "EHLO
	zeus.itg.uiuc.edu") by vger.kernel.org with ESMTP id S932123AbWDFHbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 03:31:39 -0400
Date: Thu, 6 Apr 2006 02:31:31 -0500 (CDT)
From: Damian Menscher <menscher@uiuc.edu>
X-X-Sender: menscher@zeus.itg.uiuc.edu
To: Sumit Narayan <talk2sumit@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: deleting partition does not effect superblock?
In-Reply-To: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0604060228560.8287@zeus.itg.uiuc.edu>
References: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006, Sumit Narayan wrote:

> On my system, I first created a partition with EXT3 and put some data
> on it. Later, I deleted the partition, and re-created another
> partition with the same starting block number and a higher ending
> block number. I intended to format it with another filesystem, but
> surprisingly (or maybe just to me), the superblock of the partition
> had not changed. I could still mount the new partition as the same old
> filesystem. I could see all the files which was present earlier. Doing
> 'df' showed me the older partition details (size, % used etc.).
>
> Shouldn't the superblock be changed/deleted once the partition is
> deleted? I tried a reboot, but the output remained the same.

This is the expected behavior.  A filesystem is created within the 
partition.  If you grow the partition, the filesystem doesn't 
automatically grow (use resize2fs for that).  In fact, you should 
probably read the resize2fs manpage, as it might give you some starting 
clue of what's going on.

Damian Menscher
-- 
-=#| <menscher@uiuc.edu> www.uiuc.edu/~menscher/ Ofc:(650)253-2757 |#=-
-=#| The above opinions are not necessarily those of my employers. |#=-
