Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWBFOnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWBFOnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWBFOnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:43:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36035 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932132AbWBFOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:43:14 -0500
Date: Mon, 6 Feb 2006 06:42:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: ak@suse.de, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206064253.d5328e2b.pj@sgi.com>
In-Reply-To: <20060206102337.GA3359@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<200602061109.45788.ak@suse.de>
	<20060206101156.GA1761@elte.hu>
	<200602061116.44040.ak@suse.de>
	<20060206102337.GA3359@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> the case Paul's patch is addressing: workloads which are 
> known to be global (and hence spreading out is the best-performing 
> allocation).

Just to be clear, note that even in my case, we require the node-local
policy for some allocations (into the users portion of the address
space) at the same time we require the spread policy (not
sure I like 'global' here) for other allocations (file stuff).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
