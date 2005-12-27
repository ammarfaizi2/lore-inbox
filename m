Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVL0GhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVL0GhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 01:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVL0GhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 01:37:00 -0500
Received: from mail.renesas.com ([202.234.163.13]:7855 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S932243AbVL0GhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 01:37:00 -0500
Date: Tue, 27 Dec 2005 15:36:54 +0900 (JST)
Message-Id: <20051227.153654.610521572.takata.hirokazu@renesas.com>
To: rlrevell@joe-job.com
Cc: akpm@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       takata@linux-m32r.org
Subject: Re: [WTF?] sys_tas() on m32r
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <1135365035.22177.17.camel@mindpipe>
References: <20051223061556.GR27946@ftp.linux.org.uk>
	<20051223055526.bc1a4044.akpm@osdl.org>
	<1135365035.22177.17.camel@mindpipe>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Revell <rlrevell@joe-job.com>
Date: Fri, 23 Dec 2005 14:10:34 -0500
> No one uses LinuxThreads anymore?
> 
> Even the oldest of the old (Debian stable) have moved to NPTL.
> 
> Lee
> 

Of course, I hope to migrate from LinuxThreads to NPTL.
I think it is necessary because LinuxThreads is deprecated as you said.

BTW, to port NPTL, GNU tools with TLS support are required for m32r.
We need much work to prepare tools before implementing kernel and NPTL. ;-)

On the other hand, I'm not certain that supporting NPTL is really good
thing for embedded processors like m32r.

A thread pointer register is required to keep an thread pointer value
all the time;  I'm anxious that this will increase register pressure
and worsen code performance...

-- Takata
