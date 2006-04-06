Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWDFGhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWDFGhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 02:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDFGhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 02:37:34 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:28882 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbWDFGhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 02:37:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OqxNHsoXWuy5sSC2SXHrkXtH2hhjGaiQijrA1x61cjPo4YOri76rUUIiyYaT29IJesKM0KkOh0DDxvA0TqqWDrGyTQpvp3SftboNOy4+DpCAuLOYaenKJPW1b757sSUTJ/yJYT8TmbAO5M2dgjseBWu0V+QjJ3Ydz0lN99YooDI=
Message-ID: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com>
Date: Thu, 6 Apr 2006 14:37:33 +0800
From: "Sumit Narayan" <talk2sumit@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: deleting partition does not effect superblock?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using kernel 2.6.15.4.

On my system, I first created a partition with EXT3 and put some data
on it. Later, I deleted the partition, and re-created another
partition with the same starting block number and a higher ending
block number. I intended to format it with another filesystem, but
surprisingly (or maybe just to me), the superblock of the partition
had not changed. I could still mount the new partition as the same old
filesystem. I could see all the files which was present earlier. Doing
'df' showed me the older partition details (size, % used etc.).

Shouldn't the superblock be changed/deleted once the partition is
deleted? I tried a reboot, but the output remained the same.

-- Sumit
