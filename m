Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUG2J3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUG2J3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUG2J3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:29:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5276 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267323AbUG2J3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:29:09 -0400
Date: Thu, 29 Jul 2004 02:29:12 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: haveblue@us.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
Message-Id: <20040729022912.04a0806d.pj@sgi.com>
In-Reply-To: <4108B66D.1050000@yahoo.com.au>
References: <1089871489.10000.388.camel@nighthawk>
	<20040728234255.29ef4c13.pj@sgi.com>
	<4108B66D.1050000@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick writes:
>  Can you try with 2.6.8-rc2-mm1?

This _is_ with 2.6.8-rc2-mm1.

> Does it happen continually after the system has booted?

Yes - nonstop - 4 times per millisecond, for at least as
long as the machine has been up (I'm rebooting every few
minutes, for other reasons ...).

> comment out the call to cpu_attach_domain ... Does that fix it?

Yes - that fixes it.  My ratelimited printks on NULL group cease.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
