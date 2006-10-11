Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWJKAns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWJKAns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030730AbWJKAns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:43:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:30119 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030421AbWJKAnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:43:47 -0400
Date: Wed, 11 Oct 2006 02:43:33 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SPAM: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061011004333.GA25430@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site> <20061010121003.GA19322@infradead.org> <20061010121327.GA2431@wotan.suse.de> <20061010105236.2ef0268b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010105236.2ef0268b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 10:52:36AM -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 14:13:27 +0200
> Nick Piggin <npiggin@suse.de> wrote:
> > 
> > Hmm... I agree it is more consistent, but OTOH if we're passing a
> > structure I thought it may as well just go in there. But I will
> > change unless anyone comes up with an objection.
> 
> I'd agree that it's more attractive to have the vma* in the argument list,
> but it presumably adds runtime cost: cycles and stack depth.  I don't how
> much though.

Possibly, though I considered it might end up in a register, and
considering that the vma is used both before and after the call, and
in filemap_nopage, it's quite possible that it saves a load and does
not harm stack depth. Maybe?

I don't know, I guess we can tweak it while it is in -mm?
