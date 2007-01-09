Return-Path: <linux-kernel-owner+w=401wt.eu-S1751099AbXAIIxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbXAIIxZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbXAIIxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:53:25 -0500
Received: from il.qumranet.com ([62.219.232.206]:52658 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbXAIIxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:53:24 -0500
Message-ID: <45A35800.9090602@qumranet.com>
Date: Tue, 09 Jan 2007 10:53:20 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] guest crash on 2.6.20-rc4
References: <ada4pr1mqz2.fsf@cisco.com>
In-Reply-To: <ada4pr1mqz2.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> I'm running a 64-bit Fedora 6 install as a guest on a host running
> 2.6.20-rc4 with the kvm-10 userspace release.  The CPU is a Xeon 5160
> and I have 6 GB of RAM.  The guest is given 512 MB of memory.  I left
> the guest idle overnight, and the makewhatis cron job seems to have
> triggered this:
>
>     Unable to handle kernel paging request at ffff81000ba04000 RIP:
>      [<ffffffff8025f402>] clear_page+0x16/0x44
>     PGD 8063 PUD 9063 PMD 800000000ba001e3 PTE aad8a7d881d984d9
>   

The pgd/pud/pmd entries are all correct, so it's clear the mmu is confused.

> I just let yum update the guest to the 2.6.18-1.2869.fc6 kernel, but
> I'm more suspicious of the MMU changes to kvm...
>
>   

Yes.

> I don't see anything come up in the host logs when this happens.
>
> Let me know if there is other debugging info that would be helpful.
>   

A way to reproduce this would be nice, though I realize it's asking much.

-- 
error compiling committee.c: too many arguments to function

