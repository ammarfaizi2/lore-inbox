Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVBOSj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVBOSj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVBOSj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:39:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:64227 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261811AbVBOSjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:39:22 -0500
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
	sys_page_migrate
From: Dave Hansen <haveblue@us.ibm.com>
To: Robin Holt <holt@sgi.com>
Cc: Ray Bryant <raybry@sgi.com>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Hugh DIckins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215105056.GC19658@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	 <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	 <1108242262.6154.39.camel@localhost>
	 <20050214135221.GA20511@lnx-holt.americas.sgi.com>
	 <1108407043.6154.49.camel@localhost>
	 <20050214220148.GA11832@lnx-holt.americas.sgi.com>
	 <1108419774.6154.58.camel@localhost>
	 <20050215105056.GC19658@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 10:39:12 -0800
Message-Id: <1108492753.6154.82.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 04:50 -0600, Robin Holt wrote:
> What is the fundamental opposition to an array from from-to node mappings?
> They are not that difficult to follow.  They make the expensive traversal
> of ptes the single pass operation.  The time to scan the list of from nodes
> to locate the node this page belongs to is relatively quick when compared
> to the time to scan ptes and will result in probably no cache trashing
> like the long traversal of all ptes in the system required for multiple
> system calls.  I can not see the node array as anything but the right way
> when compared to multiple system calls.  What am I missing?

I don't really have any fundamental opposition.  I'm just trying to make
sure that there's not a simpler (better) way of doing it.  You've
obviously thought about it a lot more than I have, and I'm trying to
understand your process.

As far as the execution speed with a simpler system call.  Yes, it will
likely be slower.  However, I'm not sure that the increase in scan time
is all that significant compared to the migration code (it's pretty
slow).

-- Dave

