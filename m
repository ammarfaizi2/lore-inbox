Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265860AbTF3Tkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265861AbTF3Tkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 15:40:31 -0400
Received: from mail2.megatrends.com ([155.229.80.16]:1038 "EHLO
	atl-ms1.megatrends.com") by vger.kernel.org with ESMTP
	id S265860AbTF3Tka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 15:40:30 -0400
Message-ID: <8CCBDD5583C50E4196F012E79439B45C1C7123@atl-ms1.megatrends.com>
From: Vinesh Christopher <vineshc@ami.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Vinesh Christopher <vineshc@ami.com>
Subject: How to use sendfile with a char device driver's file descriptor
Date: Mon, 30 Jun 2003 16:07:07 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a device driver which has to sent a data through network. Currently
the driver's buffer is mmaped to the user mode program which uses the
standard socket sent() call.

To improve the performance and reduce CPU overhead, I tried using sendfile()
Call. But it failed with EINVAL. 

Browsing thru the mm/filemap.c, I found the driver has to provide a readpage
functions in address_space_operations. So I added it. 

Now the sendfile() does not fail, but it returns with 0 bytes sent. Also my
function readpage is never called.

How can I use sendfile() with my driver? Is there any documentation
available on how to add address_space_operations to a driver, so that
sendfile can be used.

Any help will be appreciated

Samvinesh Christopher.
