Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUDIRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUDIRyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:54:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:24353 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261563AbUDIRyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:54:51 -0400
Date: Fri, 9 Apr 2004 10:53:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040409105349.6b40fe02.pj@sgi.com>
In-Reply-To: <200404091054.24618.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040401122802.23521599.pj@sgi.com>
	<20040406235000.6c06af9a.pj@sgi.com>
	<20040407004437.3a078f28.pj@sgi.com>
	<200404091054.24618.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It may well make sense for the O(1) scheduler to be inlining this.
> 
> Why?

I was thinking that perhaps this call was in a certain critical
performance path of the O(1) scheduler.

Turned out it wasn't - see further Nick Piggin's followups to this
same thread.

My latest bitmap/cpumask patch moves this out of line, for ia64.
The other arch's that use this large find_next_bit() code might
want to move it out too.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
