Return-Path: <linux-kernel-owner+w=401wt.eu-S1161117AbXALWKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbXALWKY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbXALWKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:10:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60937 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161117AbXALWKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:10:23 -0500
Date: Fri, 12 Jan 2007 14:10:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
Message-Id: <20070112141004.71fbd023.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701121359290.3087@schroedinger.engr.sgi.com>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	<20070112105224.GA12813@favonius>
	<20070112032820.9c995718.pj@sgi.com>
	<Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
	<20070112132016.f11ffc8a.pj@sgi.com>
	<Pine.LNX.4.64.0701121324060.2969@schroedinger.engr.sgi.com>
	<20070112135847.2d057e30.pj@sgi.com>
	<Pine.LNX.4.64.0701121359290.3087@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> If this is hidden in a macro then it may be overlooked.

Sooner or later, every line of code is important.

Shouting any one of them in #ifdef brackets creates
a noisier environment, increasing the chance of missing
another.

And besides ... the other umpteen cpuset hooks all use the
cpuset_*() style macros (except for fs/proc/base.c, which
has its own style ...).

Consistency in style is important in these matters.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
