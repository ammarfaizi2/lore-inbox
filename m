Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263840AbUFBXvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUFBXvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbUFBXvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:51:17 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:448 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263840AbUFBXvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:51:16 -0400
Date: Wed, 2 Jun 2004 16:59:02 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, rusty@rustcorp.com.au
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040602165902.73dfc977.pj@sgi.com>
In-Reply-To: <20040602162330.0664ec5d.akpm@osdl.org>
References: <20040602161115.1340f698.pj@sgi.com>
	<20040602162330.0664ec5d.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can't we just stick a PAGE_SIZE in here?

We could - either way works about as well.  Is there something special
about PAGE_SIZE here?  Is that in fact what sysfs is making available?

I can send a PAGE_SIZE hack-a-shaq if you like, or you can just code it
yourself.  If I do it, I will also fix the comment as appropriate. 
Whatever you prefer ...

	len = cpumask_scnprintf(buf, PAGE_SIZE /* XXX FIXME */, mask);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
