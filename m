Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTKNRq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTKNRq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:46:27 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:16132 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264546AbTKNRqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:46:13 -0500
To: gene.heskett@verizon.net
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
References: <20031114113224.GR21265@home.bofhlet.net>
	<bp2mab$sts$1@sea.gmane.org>
	<200311140945.36537.gene.heskett@verizon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 15 Nov 2003 02:45:28 +0900
In-Reply-To: <200311140945.36537.gene.heskett@verizon.net>
Message-ID: <87u156rghz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> On Friday 14 November 2003 08:46, Patrick Beard wrote:
> >>> FAT: Bogus number of reserved sectors
> >>> VFS: Can't find a valid FAT filesystem on dev sda

> Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
> Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF (i_pos 0)
> Nov 14 09:20:34 coyote kernel:     File system has been set read-only

Is this reproduced easy?  Looks like reading the zeroed block.
In order to know details, could you try to read the data without mount?

For example, what happen by the following repetitions? 

	dd if=/dev/sda | md5sum
	unload driver(reset device) or unplug device
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
