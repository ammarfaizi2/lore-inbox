Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVK0NoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVK0NoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVK0NoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:44:11 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:49422 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751047AbVK0NoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:44:10 -0500
Message-ID: <4389B80C.8040405@shadowen.org>
Date: Sun, 27 Nov 2005 13:43:40 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [2.6.15-rc2-mm1] Disabled flatmem on ppc32? (ARCH=powerpc)
References: <44E57FC6-A500-42B7-86F9-F1F4E72734EC@mac.com>
In-Reply-To: <44E57FC6-A500-42B7-86F9-F1F4E72734EC@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> There is a Kconfig problem for ppc32 in the latest -mm kernel.  It 
> seems that somehow the Kconfig logic for selecting memory models  under
> ARCH=powerpc doesn't quite get it right for standard flatmem  ppc32
> systems.  When I look at the memory model selection, I only see 
> sparsemem, whereas on a normal -rc2 kernel, I can see both flatmem  and
> sparsemem.  This somehow triggers a #error where the number of  reserved
> bits is less than the number necessary for the sparsemem  layout
> (because we're on a 32-bit arch without the address space for  sparsemem?).

I suspect we have neglected to add back the default for FLATMEM on 32
bit when we allowed FLATMEM to be disabled for 64 bit.  Will go and look
at it.  Thanks for the report.

-apw
