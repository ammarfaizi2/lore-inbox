Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbULIC4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbULIC4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 21:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbULIC4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 21:56:18 -0500
Received: from ozlabs.org ([203.10.76.45]:37586 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261441AbULIC4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 21:56:15 -0500
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job
	kernel/user interface
From: Rusty Russell <rusty@rustcorp.com.au>
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com>
References: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 13:56:13 +1100
Message-Id: <1102560973.15827.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 14:03 -0800, Limin Gu wrote:
> Hello,
> 
> I am looking for your comments on the attached draft, it is the job patch 
> for 2.6.9. I have posted job patch for older kernel before, but in this patch
> I have replaced the /proc/job binary ioctl calls with a new small virtual 
> filesystem (jobfs).

> +static u32   jid_hid = DISABLED;
> +char hidname[16];
> +static char       *hid = NULL;     
> +MODULE_PARM(hid, "s");

Please use module_param from linux/moduleparam.h.  MODULE_PARM is
obsolescent.

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

