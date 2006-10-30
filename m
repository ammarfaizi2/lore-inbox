Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWJ3MHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWJ3MHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWJ3MHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:07:52 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41130 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1751091AbWJ3MHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:07:50 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 30 Oct 2006 07:03:10 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] semaphore.h: add missing "sleepers = 0" initialization
In-Reply-To: <20061030105451.GN29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610300659370.7577@localhost.localdomain>
References: <Pine.LNX.4.64.0610300540140.7056@localhost.localdomain>
 <20061030105451.GN29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Al Viro wrote:

> On Mon, Oct 30, 2006 at 05:43:14AM -0500, Robert P. J. Day wrote:
> >
> >   Add the missing initialization of "sleepers" to 0 in two semaphore
> > initialization macros.
>
> Umm...  What the hell for?  Both for struct initializer and for
> compound literals all named fields that had not been mentioned get
> initialized as they would for static objects.  So that's simply
> adding more work to parser for no reason whatsoever.

i did that simply to make those initializations *consistent* across
all of the other dozen or so semaphore.h files that *do* explicitly
initialize that structure member (as you point out, for no good
reason).  i'm just as happy to whack out all of those useless
initializations, though, and submit another patch.  either way works
for me.

rday
