Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTEKIYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTEKIYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:24:34 -0400
Received: from zero.aec.at ([193.170.194.10]:26629 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261161AbTEKIYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:24:32 -0400
Date: Sun, 11 May 2003 10:37:08 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct page protection for put_dirty_page
Message-ID: <20030511083708.GB31932@averell>
References: <20030511080841.GA31266@averell> <20030511013226.25e690bf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511013226.25e690bf.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 10:32:26AM +0200, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > put_page_dirty must use the page protection of the stack VMA, not hardcoded
> >  PAGE_COPY. They can be different e.g. when the stack is set non executable
> >  via VM_STACK_FLAGS.
> 
> OK.  It seems a bit inefficient to go looking up the vma immediately after
> having created it.
> 
> How about we simply pass the desired protection in to put_dirty_page()?

Fine by me.

-Andi
