Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVCBEzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVCBEzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 23:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVCBEze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 23:55:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48259 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262170AbVCBEz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 23:55:27 -0500
Date: Tue, 1 Mar 2005 20:50:33 -0800
From: Paul Jackson <pj@sgi.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: guillaume.thouvenin@bull.net, johnpol@2ka.mipt.ru, hadi@cyberus.ca,
       tgraf@suug.ch, akpm@osdl.org, marcelo.tosatti@cyclades.com,
       davem@redhat.com, jlan@sgi.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050301205033.1140cd5a.pj@sgi.com>
In-Reply-To: <42247051.7070303@ak.jp.nec.com>
References: <4221E548.4000008@ak.jp.nec.com>
	<20050227140355.GA23055@logos.cnet>
	<42227AEA.6050002@ak.jp.nec.com>
	<1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	<20050227233943.6cb89226.akpm@osdl.org>
	<1109592658.2188.924.camel@jzny.localdomain>
	<20050228132051.GO31837@postel.suug.ch>
	<1109598010.2188.994.camel@jzny.localdomain>
	<20050228135307.GP31837@postel.suug.ch>
	<1109599803.2188.1014.camel@jzny.localdomain>
	<20050228142551.GQ31837@postel.suug.ch>
	<1109604693.1072.8.camel@jzny.localdomain>
	<20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	<1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	<42247051.7070303@ak.jp.nec.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a thought - perhaps you could see if Jay can test the performance
scaling of these changes on larger systems (8 to 64 CPUs, give or take,
small for SGI, but big for some vendors.)

Things like a global lock, for example, might be harmless on smaller
systems, but hurt big time on bigger systems.  I don't know if you have
any such constructs ... perhaps this doesn't matter.

At the very least, we need to know that performance and scaling are not
significantly impacted, on systems not using accounting, either because
it is obvious from the code, or because someone has tested it.

And if performance or scaling was impacted when accounting was enabled,
then at least we would want to know how much performance was impacted,
so that users would know what to expect when they use accounting.

> the process-creation/destruction performance on following three environment.

I think this is a good choice of what to measure, and where.  Thank-you.

> kernel was also locked up after 366th-fork() 

I have no idea what this is -- good luck finding it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
