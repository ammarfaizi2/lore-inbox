Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUJ0Aaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUJ0Aaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUJ0Aav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:30:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29361 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261512AbUJ0Aae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:30:34 -0400
Subject: Re: [RFC] remove highmem_start_page
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20041026172359.3059edec.akpm@osdl.org>
References: <1098820614.5633.3.camel@localhost>
	 <20041026172359.3059edec.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098837030.9408.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Oct 2004 17:30:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 17:23, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > +static inline int page_is_highmem(struct page *page)
> > +{
> > +	return PageHighMem(page);
> > +}
> 
> (boggle).  Why not just use PageHighMem() directly?

Because I was doing another, more complex, calculation before that and
realized about PageHighMem() later on.  Would have also made it easier
to fix if someone came up with a better way when I posted the patch :)
I take it you'd rather just see it called directly.

-- Dave

