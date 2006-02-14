Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWBNTdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWBNTdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWBNTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:33:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44471 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422680AbWBNTdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:33:13 -0500
Date: Tue, 14 Feb 2006 11:33:00 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: bharata@in.ibm.com
cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@engr.sgi.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602091058.26811.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0602141131280.14488@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602081706.26853.ak@suse.de>
 <20060209043933.GA2986@in.ibm.com> <200602091058.26811.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just took another look at this issue and I cannot see anything wrong. An 
empty zone should be ignored by the page allocator since nr_free == 0. My 
patch should not be needed.

Could you get us the contents of the struct zone that the page allocator 
is trying to get memory from?
