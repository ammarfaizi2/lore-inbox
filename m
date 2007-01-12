Return-Path: <linux-kernel-owner+w=401wt.eu-S1161110AbXALV67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbXALV67 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbXALV67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:58:59 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59846 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161110AbXALV66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:58:58 -0500
Date: Fri, 12 Jan 2007 13:58:47 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
Message-Id: <20070112135847.2d057e30.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701121324060.2969@schroedinger.engr.sgi.com>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	<20070112105224.GA12813@favonius>
	<20070112032820.9c995718.pj@sgi.com>
	<Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
	<20070112132016.f11ffc8a.pj@sgi.com>
	<Pine.LNX.4.64.0701121324060.2969@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry but there will be number of those once we get the dirty writeback 
> for cpusets fixed. Did you review that patchset (only internally mailed 
> so far).

I haven't reviewed it - sorry.  Too much stuff; too little time.
If only I had Alan's bots, which are apparently on loan now to Andrew.

> I do not think it makes much sense to do these macros for the single 
> occurrence here and otherwise.

I disagree.  If just one thing, like cpusets, does the ifdef's, it might
be easier to read.  But if several things do them in nearby code, that
code gets ugly and fries my limited brain circuits.

Even just one of them looks ugly to me -- changing what could be a
single indented line "cpuset_...(..);" line into three lines, two of
them violating the indentation.

It might look clearer to someone who is focused on that particular
change, but it adds unnecessary noise for the other 90% of the readers
of that code who are not concerned with cpusets at that point in time.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
