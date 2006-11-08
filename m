Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754592AbWKHRGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbWKHRGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbWKHRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:06:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61885 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1754592AbWKHRGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:06:51 -0500
Date: Wed, 8 Nov 2006 09:06:44 -0800
From: Paul Jackson <pj@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: clameter@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061108090644.f23d37de.pj@sgi.com>
In-Reply-To: <1162999085.14238.17.camel@twins>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<20061103172605.e646352a.pj@sgi.com>
	<20061103174206.53f2c49e.akpm@osdl.org>
	<20061104025128.ca3c9859.pj@sgi.com>
	<Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
	<20061108022136.3b9b0748.pj@sgi.com>
	<1162999085.14238.17.camel@twins>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> global fault counter

I hope we avoid frequently updated, widely accessed global
counters.  They tend to create hot cache lines on big NUMA
boxes.

Christoph said that the counters he was suggesting were
node or cpu local.  That sounds good to me.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
