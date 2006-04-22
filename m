Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWDVTwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWDVTwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDVTwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:52:39 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12228 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751105AbWDVTwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:52:38 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060422123835.GA5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422123835.GA5010@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 13:48:43 +0100
Message-Id: <1145710123.11909.241.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 14:38 +0200, Adrian Bunk wrote:
> What was the recommended way for getting userspace header at last
> year's kernel summit?

It was said that we need _incremental_ changes, and this is an attempt
to satisfy that request.

> > The important thing is that we all get our editors out and clean up the
> > _contents_ our own headers, and actually start to _think_ about the
> > visibility of any new header-file content we introduce. Let's not
> > concentrate too much on the implementation details of how we actually
> > get those to userspace.
> 
> Currently, it's said the kernel headers aren't suitable for userspace.

Indeed they aren't.

> After the cleanups you propose, the kernel headers will be suitable for 
> userspace (the copy steps you propose are not required, distributions 
> could equally start to copy the verbatim headers again).

After the _first_ stage of the cleanups I propose, the export step will
still be necessary. You'll need to pick those headers which are intended
to be user-visible, and leave behind those which are not. 

If we actually go on to abolish __KERNEL__ and move the public headers
to a separate directory, you're right -- as I said, one day hopefully
it'll just be 'cp -a'. But that is not the _first_ stage. We need to do
this incrementally.

> If everyone is working in a different direction, this is only wasting 
> work.

The stated plan is to start with a simple export mechanism which lets us
see the mess we have at the moment and work on the _real_ problem -- the
actual contents of the headers. Then to proceed towards the goal you
stated, which is what we wanted all along.

Who would be working in a different direction? 

-- 
dwmw2

