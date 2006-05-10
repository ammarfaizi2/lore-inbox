Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWEJXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWEJXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWEJXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:32:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23300 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965082AbWEJXcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:32:24 -0400
Message-ID: <44627733.4010305@vmware.com>
Date: Wed, 10 May 2006 16:28:51 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
References: <20060509084945.373541000@sous-sol.org> <20060509085150.509458000@sous-sol.org>
In-Reply-To: <20060509085150.509458000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> Change LOAD_OFFSET so that the kernel has virtual addresses in the elf header fields.
>
> Unlike bare metal kernels, Xen kernels start with virtual address
> management turned on and thus the addresses to load to should be
> virtual addresses.

This patch interferes with using a traditional bootloader.  The loader 
for Xen should be smarter - it already has VIRT_BASE from the xen_guest 
section, and can simply add the relocation to these header fields.  This 
is unnecessary, and one of the many reasons a Xen kernel can't run in a 
normal environment.

Zach
