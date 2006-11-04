Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWKDB0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWKDB0j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 20:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWKDB0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 20:26:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4328 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932306AbWKDB0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 20:26:38 -0500
Date: Fri, 3 Nov 2006 17:26:05 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061103172605.e646352a.pj@sgi.com>
In-Reply-To: <20061103143145.85a9c63f.akpm@osdl.org>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> But in this application which you are proposing, any correlation with
> elapsed walltime is very slight.  It's just the wrong baseline to use. 
> What is the *sense* in it?

Ah - but time is cheap as dirt, and scales like the common cold virus.
That makes it sinfully attractive for secondary affect placement cache
hints like this.

What else would you suggest?

Same question applies, I suppose, to my zonelist caching patch that is
sitting in your *-mm patch stack, where you also had doubts about using
wall clock time to decay the fullnode hints.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
