Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWBOAA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWBOAA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBOAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:00:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:20194 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422802AbWBOAAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:00:55 -0500
Subject: [PATCH 0/2] Add support to map multiple blocks in get_block() and
	remove get_blocks()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Cc: christoph <hch@lst.de>, akpm@osdl.org, pbadari@us.ibm.com, mcao@us.ibm.com
Content-Type: text/plain
Date: Tue, 14 Feb 2006 16:02:01 -0800
Message-Id: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following patches add support to map multiple blocks in ->get_block().
This is will allow us to handle mapping of multiple disk blocks for
mpage_readpages() and mpage_writepages() etc. Instead of adding new
argument, I use "b_size" to indicate the amount of disk mapping needed
for get_block().

Now that get_block() can handle multiple blocks, there is no need
for ->get_blocks() which was added for DIO. Second patch removes
them.

[PATCH 1/2] map multiple blocks in get_block() for mpage_readpages()

[PATCH 2/2] remove ->get_blocks() support


Andrew, Please let me know if you want to pick these up into -mm
tree, since they need to be integrated with Mingming's ext3 multiblock
support.

Comments ?

Thanks,
Badari

