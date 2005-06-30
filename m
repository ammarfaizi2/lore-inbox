Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVF3QPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVF3QPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVF3QP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:15:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:44252 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262784AbVF3QPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:15:06 -0400
Date: Thu, 30 Jun 2005 18:15:03 +0200
From: Andi Kleen <ak@suse.de>
To: Stuart_Hayes@Dell.com
Cc: ak@suse.de, riel@redhat.com, andrea@suse.dk, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050630161503.GA1627@wotan.suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C040240AE4E@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C040240AE4E@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 03:16:51PM -0500, Stuart_Hayes@Dell.com wrote:
> >> set and isn't executable.  And, since PAGE_KERNEL (with _PAGE_NX set)
> >> didn't match the original pages attributes, the 512 PTEs weren't
> >> reverted back into a large page.  (Also, __change_page_attr() did
> >> *another* get_page() on the page containing these 512 PTEs, so now
> >> the page_count has gone up to 3, instead of going back down to 1 (or
> >> staying at 2).)
> > 
> > That should be already fixed.
> 
> It doesn't appear to be fixed (in the i386 arch).  The

I only fixed it for x86-64 correct. Does it work for you on x86-64?

If yes then the changes could be brought over.

What do you all need this for anyways?

-Andi
