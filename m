Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWBFJKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWBFJKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWBFJKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:10:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6812 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750819AbWBFJKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:10:07 -0500
Date: Mon, 6 Feb 2006 01:09:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206010951.d9c63b61.pj@sgi.com>
In-Reply-To: <20060206085155.GA9436@elte.hu>
References: <20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
	<20060205232253.ddbf02d7.pj@sgi.com>
	<20060206074334.GA28035@elte.hu>
	<20060206001959.394b33bc.pj@sgi.com>
	<20060206082258.GA1991@elte.hu>
	<20060206004720.0374b820.pj@sgi.com>
	<20060206085155.GA9436@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes, but still that is a global attribute:

Ok ... I am starting to see where you are going with this.

Well, certainly not global in the sense that a selected cache would be
spread over the whole system.  The data set read in by the job in one
cpuset must not pollute the memory of another cpuset.

But it -might- work to mark certain caches to be memory spread across
the current cpuset (to be precise, across current->mems_allowed), as
the default kernel placement policy for those selected caches, with
no per-cpuset mechanism to specify otherwise.

Or it might not work.

I don't know tonight.

I will have to wait for others to chime in.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
