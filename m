Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWCBOYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCBOYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCBOYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:24:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15265 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751257AbWCBOYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:24:18 -0500
Date: Thu, 2 Mar 2006 06:23:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [PATCH] Proc: move proc fs hooks from cpuset.c to
 proc/fs/base.c
Message-Id: <20060302062359.5940ff7f.pj@sgi.com>
In-Reply-To: <20060302084739.GC21902@infradead.org>
References: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
	<20060302084739.GC21902@infradead.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems pointless.  This just increases #ifdef churn for no gain.

Take a look at fs/proc/base.c.  That's how pretty much all the
other proc hooks are done, with ifdef's around their proc hooks.

ifdef minimization is a good goal, yes.

But uniformity of practice is another good goal.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
