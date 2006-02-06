Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWBFUWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWBFUWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWBFUWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:22:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59780 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932363AbWBFUWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:22:52 -0500
Date: Mon, 6 Feb 2006 12:22:31 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206122231.04878dda.pj@sgi.com>
In-Reply-To: <20060206084001.GA5600@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
	<20060205232253.ddbf02d7.pj@sgi.com>
	<20060206074334.GA28035@elte.hu>
	<20060206001959.394b33bc.pj@sgi.com>
	<20060206082258.GA1991@elte.hu>
	<20060206084001.GA5600@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> in other words: the spreading out likely _hurts_ performance in the 
> typical case (which prefers node-locality), but when you are using 
> multiple cpusets you want to opt for fairness between projects, over 
> opportunistic optimizations such as node-local allocations.

Spreading might be useful for this, but it is not what is driving my
interest in it.

My immediate goal is to obtain spreading across the nodes within of a
single cpuset, running a single job, not "fairness between projects."

I have little interest in cross (between) project memory management
beyond simply isolating them from each other.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
