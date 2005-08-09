Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVHIUwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVHIUwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVHIUwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:52:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964956AbVHIUwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:52:14 -0400
Date: Tue, 9 Aug 2005 13:52:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: 7eggert@gmx.de
Cc: Chris Wright <chrisw@osdl.org>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809205206.GW7762@shell0.pdx.osdl.net>
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it> <E1E2aaq-0002WB-Tj@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E2aaq-0002WB-Tj@be1.lrz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bodo Eggert (harvested.in.lkml@7eggert.dyndns.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> > * David Madore (david.madore@ens.fr) wrote:
> 
> >> * Second, a much more extensive change, the patch introduces a third
> >> set of capabilities for every process, the "bounding" set.  Normally
> > 
> > this is not a good idea.  don't add more sets. if you really want to
> > work on this i'll give you all the patches that have been done thus far,
> > plus a set of tests that look at all the execve, ptrace, setuid type of
> > corner cases.
> 
> How are you going to tell processes that may exec suid (or set-capability-)
> programs from those that aren't supposed to gain certain capabilities?

typically you'd expect exec suid will reset to full caps.
