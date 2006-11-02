Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWKBLcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWKBLcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 06:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbWKBLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 06:32:22 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:28802 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S1752054AbWKBLcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 06:32:21 -0500
Message-ID: <4549D722.5090007@ti.uni-mannheim.de>
Date: Thu, 02 Nov 2006 12:31:46 +0100
From: Guillermo Marcus <marcus@ti.uni-mannheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <loom.20061101T120846-320@post.gmane.org> <454899E9.1090900@ti.uni-mannheim.de> <20061102083109.GB1377@flint.arm.linux.org.uk>
In-Reply-To: <20061102083109.GB1377@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Russell King wrote:
> On Wed, Nov 01, 2006 at 01:58:17PM +0100, Guillermo Marcus Martinez wrote:
>> My suggestion would be to add two functions: pci_map_consistent() and
>> dma_map_coherent() to address this issue, and their corresponding
>> unmap's. That will make sure all that is needed is done, is a clean and
>> consistent with the pci_ and dma_ APIs, and fills a mmap requirement not
>> covered by the other functions.
> 
> You might want to look through include/asm-arm/dma-mapping.h to see if
> an architecture already has considered that and the interface they
> implemented.
> 

Nice! Thanks. I think the issue of mapping a coherent area to user space
is fairly general. Should not this be promoted to be part of the general
dma-api? (that is, not a platform specific function)
