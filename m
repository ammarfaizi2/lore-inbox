Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWJKJWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWJKJWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJKJWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:22:00 -0400
Received: from mail.suse.de ([195.135.220.2]:26861 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750750AbWJKJV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:21:59 -0400
Date: Wed, 11 Oct 2006 11:21:58 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-ID: <20061011092158.GA28449@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org> <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010230042.3d4e4df1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:00:42PM -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 15:39:22 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > But I see that it does read twice. Do you want that behaviour retained? It
> > seems like at this level it would be logical to read it once and let lower
> > layers take care of any retries?
> 
> argh.  Linus has good-sounding reasons for retrying the pagefault-path's
> read a single time, but I forget what they are.  Something to do with
> networked filesystems?  (adds cc)

While you're there, can anyone tell me why we want an external
ptracer to be able to access pages that are outside i_size? I
haven't removed the logic of course, but I'm curious about the
history and usage of such a thing.


