Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVHNWvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVHNWvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 18:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHNWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 18:51:11 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:44487 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932340AbVHNWvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 18:51:11 -0400
Date: Mon, 15 Aug 2005 00:51:01 +0200
From: Voluspa <voluspa@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Message-Id: <20050815005101.26df083a.voluspa@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-08-14 20:10:49 Nick Warne wrote:

>Note the last sentence:
>
>' This  variation  is  designed for use with "libraries" of drive 
>identification information, and can also be used on ATAPI drives which may  
>give  media errors with the standard mechanism.

My jaw just clonked on the table. And the media error at hand made you
buy a new CD-RW. There is precedence for this (remember the blaming X and
other programs in the keyboard driver?) so perhaps the kernel people could
amend the error like:

hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
ide: Did you just run "hdparm -I" or do you use a nosy desktop?

Mvh
Mats Johannesson
--
