Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJWXqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTJWXqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:46:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:47293 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261895AbTJWXqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:46:43 -0400
Date: Thu, 23 Oct 2003 16:46:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO
 testingon2.6.0-test7-mm1)
Message-Id: <20031023164638.5c32b80f.akpm@osdl.org>
In-Reply-To: <20031023233700.GJ21490@fs.tum.de>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
	<20031020142727.GA4068@in.ibm.com>
	<1066693673.22983.10.camel@ibm-c.pdx.osdl.net>
	<20031021121113.GA4282@in.ibm.com>
	<1066869631.1963.46.camel@ibm-c.pdx.osdl.net>
	<20031023104923.GA11543@in.ibm.com>
	<20031023135030.GA11807@in.ibm.com>
	<20031023155937.41b0eeda.akpm@osdl.org>
	<20031023232006.GH21490@fs.tum.de>
	<20031023162539.0051249d.akpm@osdl.org>
	<20031023233700.GJ21490@fs.tum.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> > That was before we knew that it craps out when compiled on RH9.
> 
> And one of the arguments I had for making it dependent on EXPERIMENTAL 
> instead of enabling it unconditionally was:
> 
> - it's less tested (there might be miscompilations in some part of the
>   kernel with some supported compilers)

That's why I enabled it unconditionally.

> -Os has it's benefits on some systems, so it shouldn't be totally hidden 
> under EMBEDDED. OTOH, it's less tested, so only people who know what 
> they are doing should use it (EXPERIMENTAL plus help text).

It causes kernels to crash on a major linux distribution.  We need to
either make it very hard to turn on, or just forget it altogether.

