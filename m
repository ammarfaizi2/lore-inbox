Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVBYRqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVBYRqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVBYRqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:46:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:2493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262751AbVBYRqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:46:14 -0500
Date: Fri, 25 Feb 2005 09:45:25 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050225174525.GF28536@shell0.pdx.osdl.net>
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <421F6139.5020207@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421F6139.5020207@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jay Lan (jlan@sgi.com) wrote:
> Andrew Morton wrote:
> >Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
> >
> >>In my understanding, what Andrew Morton said is "If target functionality 
> >>can
> >>implement in user space only, then we should not modify the kernel-tree".
> >
> >
> >fork, exec and exit upcalls sound pretty good to me.  As long as
> >
> >a) they use the same common machinery and
> >
> >b) they are next-to-zero cost if something is listening on the netlink
> >   socket but no accounting daemon is running.
> >
> >Question is: is this sufficient for CSA?
> 
> Yes, fork, exec, and exit upcalls are sufficient for CSA.

As soon as you want to throttle tasks at the Job level, this would be
insufficient.  But, IIRC, that's not one of PAGG/Job/CSA's requirements
right?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
