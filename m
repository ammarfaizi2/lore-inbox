Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUEZXo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUEZXo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUEZXo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:44:26 -0400
Received: from mail.tpgi.com.au ([203.12.160.101]:16329 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261210AbUEZXoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:44:25 -0400
Message-ID: <40B52A7D.6090102@linuxmail.org>
Date: Thu, 27 May 2004 09:38:37 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP support for drain local pages v2.
References: <40B473F7.4000100@linuxmail.org>	<20040526223255.GB15278@redhat.com>	<40B520A2.2060508@linuxmail.org> <20040526162607.0f177009.akpm@osdl.org>
In-Reply-To: <20040526162607.0f177009.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Andrew Morton wrote:
> I think we only need a single entry point.  Make it a new "drain_percpu_pages()"
> or such to break unconverted callers, switch callers of drain_local_pages()
> over to the new function.   It needs no SMP ifdefs in it - on_each_cpu() will
> do the right thing on UP.
> 
> But until something which needs this change is merged into the tree I'd say
> that this patch should live with the patch which requires it.

CPU hotplugging uses drain_local_pages, and shouldn't drain the pcp lists for all cpus. That's why I 
left the original version alone.

I'm submitting it now in preparation for merging, but Pavel's work on SMP support for swsusp should 
be using this too. (It's not, but it should be).

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur
with alarming frequency, order arises from chaos, and no one is given credit.
