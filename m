Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWBTQYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWBTQYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWBTQYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:24:23 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:42346 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161003AbWBTQYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:24:21 -0500
Message-ID: <43FA7677.3040901@de.ibm.com>
Date: Tue, 21 Feb 2006 03:09:59 +0100
From: Heiko J Schick <schihei@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Roland Dreier <rolandd@cisco.com>, SCHICKHJ@de.ibm.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       RAISCH@de.ibm.com, HNGUYEN@de.ibm.com, MEDER@de.ibm.com,
       linuxppc64-dev@ozlabs.org
Subject: Re: [openib-general] Re: [PATCH 21/22] ehca main file
References: <20060218005532.13620.79663.stgit@localhost.localdomain>	<20060218005759.13620.10968.stgit@localhost.localdomain> <20060220152213.GD19895@krispykreme>
In-Reply-To: <20060220152213.GD19895@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anton,

thanks for your help!

 >>+#include "hcp_sense.h"		/* TODO: later via hipz_* header file */
 >>+#include "hcp_if.h"		/* TODO: later via hipz_* header file */
 >
 >
 > I count 88 TODOs in the driver, it would be nice to get rid of some of
 > them like the two above, so we can concentrate on the important TODOs :)

We will remove the TODOs soon as possible.

 >>+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12)
 >>+#define EHCA_RESOURCE_ATTR_H(name)                                         \
 >>+static ssize_t  ehca_show_##name(struct device *dev,                       \
 >>+				 struct device_attribute *attr,            \
 >>+				 char *buf)
 >>+#else
 >>+#define EHCA_RESOURCE_ATTR_H(name)                                         \
 >>+static ssize_t  ehca_show_##name(struct device *dev,                       \
 >>+				 char *buf)
 >>+#endif
 >
 >
 > No need for kernel version ifdefs.

The point is that our module have to run on Linux 2.6.5-7.244 (SuSE SLES 9 SP3), too.
This was the reason why we've included the ifdefs. We can change the ifdefs to
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2.6.5) to mark that this code is used for
Linux 2.6.5 compatibility.

Regards,
	Heiko
