Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSLQFzn>; Tue, 17 Dec 2002 00:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSLQFzm>; Tue, 17 Dec 2002 00:55:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47069 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264690AbSLQFzm>;
	Tue, 17 Dec 2002 00:55:42 -0500
Date: Tue, 17 Dec 2002 11:48:46 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-'
Message-ID: <20021217114846.A30837@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <Pine.LNX.4.50.0212161831340.1804-100000@montezuma.mastecende.com> <20021217002740.598D32C05B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021217002740.598D32C05B@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Dec 17, 2002 at 11:17:05AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 11:17:05AM +1100, Rusty Russell wrote:
> 
> BTW, this was done for (1) simplicity, (2) so KBUILD_MODNAME can be
> used to construct identifiers, and (3) so parameters when the module
> is built-in have a consistent name.
> 
Ok, I see it now, this magic happens in scripts/Makefile.lib. 
My module has been built outside the kernel build system, that's
why I saw this problem.

I guess avoiding '-' should do it, but is there a simple way to 
correctly build (simple, test) modules outside the kernel tree now?

Thanks,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
