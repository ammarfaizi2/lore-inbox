Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbUDFHYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUDFHYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:24:38 -0400
Received: from ozlabs.org ([203.10.76.45]:50088 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263648AbUDFHYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:24:36 -0400
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       colpatch@us.ibm.com
In-Reply-To: <20040405234552.23f810cd.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1081128401.18831.6.camel@bach> <20040405000528.513a4af8.pj@sgi.com>
	 <1081150967.20543.23.camel@bach> <20040405010839.65bf8f1c.pj@sgi.com>
	 <1081227547.15274.153.camel@bach> <20040405230601.62c0b84c.pj@sgi.com>
	 <1081233543.15274.190.camel@bach>  <20040405234552.23f810cd.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1081235999.28514.9.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 17:24:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 16:45, Paul Jackson wrote:
> > That'd be a noop, I think.
> 
> Huh?

You passed the structs by value: you wanted to pass the address.

Linus dislikes typedefs for various reasons: if it's actually a struct
on some archs and not on others, he likes it.  Otherwise he historically
prefers the struct.  However, Linus is not the most reliable barometer.

Ingo added task_t because it make some lines fit in the sched.c code,
for example.  We removed list_t in 2.5.34.

I dislike typedefs because you have an extra name for something, and can
predeclare structs, which saves gratuitous header file inclusion.

Hope that clarifies,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

