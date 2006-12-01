Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936521AbWLAQ1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936521AbWLAQ1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936523AbWLAQ1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:27:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40345 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S936521AbWLAQ1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:27:43 -0500
Date: Fri, 1 Dec 2006 08:27:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061130235117.018c3c70.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0612010823170.17445@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <20061103172605.e646352a.pj@sgi.com>
 <20061103174206.53f2c49e.akpm@osdl.org> <20061104025128.ca3c9859.pj@sgi.com>
 <Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
 <20061130235117.018c3c70.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006, Paul Jackson wrote:

> Anybody have any idea which is the case?

You can rely on those to increment and count events if it does not matter 
that we may miss an event once in a while. And I think that is the case 
here.

The counters may only switched off for embedded systems. We could just 
remove the CONFIG option if necessary. The event counter operations are in 
critical paths of the VM though and I would think that embedded systems 
with no need for vmstat want those as efficient as possible.
