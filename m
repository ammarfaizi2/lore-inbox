Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUKNGS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUKNGS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUKNGS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:18:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261241AbUKNGS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:18:58 -0500
Date: Sun, 14 Nov 2004 06:18:56 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: Parenthize nth_page() macro arg, in linux/mm.h.
Message-ID: <20041114061855.GA11738@parcelfarce.linux.theplanet.co.uk>
References: <200411140517.iAE5HOqM010399@hera.kernel.org> <20041114061016.GF3217@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114061016.GF3217@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 10:10:16PM -0800, William Lee Irwin III wrote:
> On Sat, Nov 13, 2004 at 07:43:08PM +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2092.7.2, 2004/11/13 14:43:08-05:00, jgarzik@pobox.com
> > 	Parenthize nth_page() macro arg, in linux/mm.h.
> >  mm.h |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > diff -Nru a/include/linux/mm.h b/include/linux/mm.h
> > --- a/include/linux/mm.h	2004-11-13 21:17:35 -08:00
> > +++ b/include/linux/mm.h	2004-11-13 21:17:35 -08:00
> > @@ -41,7 +41,7 @@
> >  #define MM_VM_SIZE(mm)	TASK_SIZE
> >  #endif
> > -#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + n)
> > +#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> 
> Okay, #1 the ((page)) thing should be unnecessary. If it is necessary,
> arch code is broken, which leads to #2: this came about because alpha
> wasn't parenthesizing its args in pfn_to_page(); where did the fix for
> that go?

In my tree; I'm preparing -bk23-bird1 right now, will post in an hour or so.
