Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTEFUlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTEFUlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:41:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18561
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261860AbTEFUkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:40:37 -0400
Subject: Re: [RFC][Patch] fix for irq_affinity_write_proc v2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com>
References: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 20:54:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 20:03, Keith Mannthey wrote:
> Hello,
>   irq_affinity_write_proc currently directly calls set_ioapic_affinity
> which writes to the ioapic.  This undermines the work done by kirqd by
> writing a cpu mask directly to the ioapic. I propose the following patch
> to tie the /proc affinity writes into the same code path as kirqd. 
> Kirqd will enforce the affinity requested by the user.   

Why should the kernel be enforcing policy here. You have to be root to 
do this, and root should have the ability to configure apparently stupid
things because they may find them useful.


