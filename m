Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUFKJxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUFKJxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 05:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUFKJxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 05:53:46 -0400
Received: from main.gmane.org ([80.91.224.249]:25251 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263769AbUFKJxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 05:53:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Fri, 11 Jun 2004 11:50:39 +0200
Message-ID: <cabvf1$2ts$1@sea.gmane.org>
References: <04061008351700.11472@tabby> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAFnNl61uL20Wfr6jkoh79oAEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.41.133.51
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040326
X-Accept-Language: en-us, en
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAFnNl61uL20Wfr6jkoh79oAEAAAAA@casabyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> You are missing the model:
> 
> To enable executable stack/heap you would:
> 
> if ((fd = open("/proc/self/NX",O_RDWR)) >= 0) {
>    write(fd,"1",1);
>    close(fd);
> }
> 
> (disabling would be symmetric with "0")
> 
> Because this is a sequence of specific instructions (that shouldn't exist in the
> default library to prevent stack return hack invocation) these instructions would
> exist only in programs that want to be EX anyway.

Even such a protection model (a sequence of 3 syscalls to enable or
disable NX) can be easily bypassed by an attacker. The classic method
of return-into-libc (with a small variation that I would call
chained-returns-into-libc) still works.

As other people already said on this list: the ability to disable NX
is a *bad* thing for security.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.

