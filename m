Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUDSSki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUDSSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:40:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:6633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbUDSSjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:39:44 -0400
Date: Mon, 19 Apr 2004 11:38:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, brking@us.ibm.com
Subject: Re: [PATCH] Use workqueue for call_usermodehelper
Message-ID: <20040419113854.H22989@build.pdx.osdl.net>
References: <1082345766.30154.13.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082345766.30154.13.camel@bach>; from rusty@rustcorp.com.au on Mon, Apr 19, 2004 at 01:36:06PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> [ Vatsa, this should solve your NUMA+HOTPLUG_CPU deadlock too, I think ]
> 
> This uses the create_singlethread_workqueue() function presented in the
> last patch, although it could just as easily use create_workqueue().

Nice, this seems like it should fixup the problem Brian was seeing too,
and maintain return code from kernel_thread(), etc. instead of the async
option.  Brian, did you give these changes a whirl? (they're in latest
-mm tree)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
