Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbULSNid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbULSNid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 08:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbULSNid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 08:38:33 -0500
Received: from [213.146.154.40] ([213.146.154.40]:31212 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261289AbULSNiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 08:38:01 -0500
Date: Sun, 19 Dec 2004 13:37:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mike Werner <werner@sgi.com>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [patch 2.6.10-rc3 1/4] agpgart: allow multiple backends to be initialized
Message-ID: <20041219133758.GB599@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Werner <werner@sgi.com>, davej@codemonkey.org.uk,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <200412171255.59390.werner@sgi.com> <20041218144813.GA7635@infradead.org> <200412180917.14255.werner@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412180917.14255.werner@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 09:17:14AM -0800, Mike Werner wrote:
> > The agp_bridge_find function pointer is bogus, that way you can only support
> > one backend at a time. 
> Obviously you mean one type of backend here.
> I have tried to simplify this patch as much as possible so that it only tries to do one thing
> and that is just the api change. I think the searching for valid bridges is a separate issue
> since none of the currently supported hardware needs it. The only possible platform
> that I assumed might is amd64 and Andi Kleen specifically told me it doesn't.

I agree that it's a separate issue.  So keep the function poniter out for
the time beeing and we can discuss it last.

> I don't agree that you *must* pass the agp_bridge_data pointer for every method.
> You don't need it for bind/unbind/free if you associate each memory region
> allocated using agp_allocate_memory(bridge,...) with a particular bridge 
> which is what the patch does. That is, agp_memory knows which bridge it belongs to.

Yes, agreed.  But you need to pass the agp_bridge_data to each function in
some way.
