Return-Path: <linux-kernel-owner+w=401wt.eu-S1751281AbXAIKTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbXAIKTd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXAIKTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:19:32 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:27703 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbXAIKTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:19:31 -0500
Message-ID: <45A36C22.6010009@chelsio.com>
Date: Tue, 09 Jan 2007 02:19:14 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
Subject: Re: [PATCH 1/10] cxgb3 - main header files
References: <20061220124125.6286.17148.stgit@localhost.localdomain> <45918CA4.3020601@garzik.org>
In-Reply-To: <45918CA4.3020601@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 10:19:18.0148 (UTC) FILETIME=[9EF96C40:01C733D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Divy Le Ray wrote:
>> From: Divy Le Ray <divy@chelsio.com>
>>
>> This patch implements the main header files of
>> the Chelsio T3 network driver.
>>
>> Signed-off-by: Divy Le Ray <divy@chelsio.com>
>
> Once you think it's ready, email me a URL to a single patch that adds 
> the driver to the latest linux-2.6.git kernel.  Include in the email a 
> description of the driver and signed-off-by line, which will get 
> directly included in the git changelog.
>
> Adding new drivers is a bit special, because we want to merge it as a 
> single changeset, but that would create a patch too large to review on 
> the common kernel mailing lists.
Jeff,

You can grab the monolithic patch at this URL:
http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

This patch adds support for the latest 1G/10G Chelsio adapter, T3.
It is required by the T3 RDMA driver Steve Wise submitted.

Here is a brief description of its content:

drivers/net/cxgb3/adapter.h,
drivers/net/cxgb3/common.h,
drivers/net/cxgb3/cxgb3_ioctl.h,
drivers/net/cxgb3/firmware_exports.h:
    main header files

drivers/net/cxgb3/cxgb3_main.c
    main source file

drivers/net/cxgb3/t3_hw.c
    HW access routines

drivers/net/cxgb3/sge.c,
drivers/net/cxgb3/sge_defs.h
    scatter/gather engine

drivers/net/cxgb3/ael1002.c,
drivers/net/cxgb3/mc5.c,
drivers/net/cxgb3/vsc8211.c,
drivers/net/cxgb3/xgmac.c
    on board memory, MAC and PHY management

drivers/net/cxgb3/cxgb3_ctl_defs.h,
drivers/net/cxgb3/cxgb3_defs.h,
drivers/net/cxgb3/cxgb3_offload.h,
drivers/net/cxgb3/l2t.h, drivers/net/cxgb3/t3_cpl.h,
drivers/net/cxgb3/t3cdev.h
    offload operations header files

drivers/net/cxgb3/cxgb3_offload.c,
drivers/net/cxgb3/l2t.c
    offload capabilities

drivers/net/cxgb3/regs.h
    register definitions

drivers/net/Kconfig
drivers/net/Makefile
drivers/net/cxgb3/Makefile
drivers/net/cxgb3/version.h
    build files and versioning

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---
