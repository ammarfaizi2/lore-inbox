Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVCAUv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVCAUv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCAUvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:51:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15819 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262071AbVCAUun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:50:43 -0500
Date: Tue, 1 Mar 2005 12:40:41 -0800
From: Paul Jackson <pj@sgi.com>
To: hadi@cyberus.ca
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, kaigai@ak.jp.nec.com,
       marcelo.tosatti@cyclades.com, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050301124041.2403d641.pj@sgi.com>
In-Reply-To: <1109592658.2188.924.camel@jzny.localdomain>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<421CEC38.7010008@sgi.com>
	<421EB299.4010906@ak.jp.nec.com>
	<20050224212839.7953167c.akpm@osdl.org>
	<20050227094949.GA22439@logos.cnet>
	<4221E548.4000008@ak.jp.nec.com>
	<20050227140355.GA23055@logos.cnet>
	<42227AEA.6050002@ak.jp.nec.com>
	<1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	<20050227233943.6cb89226.akpm@osdl.org>
	<1109592658.2188.924.camel@jzny.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamal wrote:
> What was wrong with just going ahead and just always
> invoking your netlink_send()? 

I think the hope was to reduce the cost of the accounting hook in fork
to "next-to-zero" if accounting is not being used on that system.

See Andrew's query earlier:
> b) they are next-to-zero cost if something is listening on the netlink
>    socket but no accounting daemon is running.

Presumably sending an ignored packet costs something, quite possibly
more than "next-to-zero".

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
