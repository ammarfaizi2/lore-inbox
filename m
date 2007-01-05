Return-Path: <linux-kernel-owner+w=401wt.eu-S1422702AbXAETlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbXAETlG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbXAETlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:41:05 -0500
Received: from xenotime.net ([66.160.160.81]:43422 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422702AbXAETlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:41:04 -0500
Date: Fri, 5 Jan 2007 11:41:11 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Olaf Hering <olaf@aepfle.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       kernel@bardioc.dyndns.org
Subject: Re: [PATCH] sysrq: showBlockedTasks is sysrq-X
Message-Id: <20070105114111.879fbedc.rdunlap@xenotime.net>
In-Reply-To: <20070105193605.GA14592@aepfle.de>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net>
	<20070105193605.GA14592@aepfle.de>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 20:36:05 +0100 Olaf Hering wrote:

> On Fri, Jan 05, Randy Dunlap wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > SysRq showBlockedTasks is not done via B or T, it's done via X,
> > so put that in the Help message.
> 
> Weird, who failed to run this command before adding new stuff?!
> find * -type f -print0 | xargs -0 env -i grep -nw register_sysrq_key
> 
> sysrq x is for xmon, see arch/powerpc/xmon/xmon.c
> Better switch the new stuff to 'z' or 'w'
> -

OK.  There is also a collision on 'c':

drivers/net/ibm_emac/ibm_emac_debug.c:195:
    return register_sysrq_key('c', &emac_sysrq_op)

and sysrq_crashdump_op.  I'd say ibm_emac needs to change too.

I'll resend.
---
~Randy
