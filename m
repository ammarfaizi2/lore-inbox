Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVAMRS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVAMRS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVAMRSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:18:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33187 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261206AbVAMRPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:15:00 -0500
Date: Thu, 13 Jan 2005 09:14:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, ak@muc.de, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <41E5EF2B.3050105@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0501130912000.18742@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501130258210.4577-100000@localhost.localdomain>
 <41E5EF2B.3050105@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Nick Piggin wrote:

> I'm still not too sure that all places read the pte atomically where needed.
> But presently this is not a really big concern because it only would
> really slow down i386 PAE if anything.

S/390 is also affected. And I vaguely recall special issues with sparc
too. That is why I dropped the arch support for that a long time ago from
the patchset. Then there was some talk a couple of months back to use
another addressing mode on IA64 that may also require 128 bit ptes. There
are significantly different ways of doing optimal SMP locking for these
scenarios.
