Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbUKXWaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUKXWaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUKXWaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:30:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:44468 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262870AbUKXW3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:29:34 -0500
Subject: Re: Suspend 2 merge: 18/51: Debug page_alloc support.
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101327214.3425.6.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295326.5805.259.camel@desktop.cunninghams>
	 <1101312173.8940.47.camel@localhost>
	 <1101327214.3425.6.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101335184.8940.433.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 24 Nov 2004 14:26:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 12:17, Nigel Cunningham wrote:
> On Thu, 2004-11-25 at 03:02, Dave Hansen wrote:
> > On Wed, 2004-11-24 at 04:58, Nigel Cunningham wrote:
> > > +#ifdef CONFIG_HIGHMEM
> > > +	if (page >= highmem_start_page) 
> > > +		return 0;
> > > +#endif
> > 
> > There's a patch pending in -mm to kill highmem_start_page.  Please use
> > PageHighMem().
> 
> That's not out-of-line, is it? (We use it while resuming too, IIRC).
> I'll take a look.

Nope.  That's a simple single-bit page->flags check.

-- Dave

