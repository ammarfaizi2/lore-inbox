Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbULFJ4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbULFJ4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbULFJ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:56:14 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:48645 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261472AbULFJ4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:56:12 -0500
Date: Mon, 6 Dec 2004 10:56:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Landley <rob@landley.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, David Greaves <david@dgreaves.com>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       Mariusz Mazur <mmazur@kernel.pl>, Arjan van de Ven <arjanv@redhat.com>,
       andersen@codepoet.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041206095604.GA2828@pclin040.win.tue.nl>
References: <19865.1101395592@redhat.com> <41B30AF2.6060505@dgreaves.com> <20041205155743.GA24304@pclin040.win.tue.nl> <200412051805.20980.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412051805.20980.rob@landley.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 06:05:20PM -0500, Rob Landley wrote:

> Bluntlly, I don't understand why "#include <linux/version.h>" and several 
> #ifdefs is an improvement on "#include <linux/loop.h>" with no #ifdefs.

Look at the history of util-linux.

Of course it did the latter. Up to the point that broke.
Then invented a silly workaround. Up to the point that broke.
Then tried something else. Up to the point that broke.
Then gave up including this particular header and made a
private copy. Again, there is some painful history with
the private copy. I showed the current version.

You see - util-linux advertises: all kernels, all archs,
all libc versions since 4.6.27.
If the kernel improves today, it is too late for util-linux.

But yes, the include situation is painful.
It seems there is some recent progress. We'll see what happens.

Andries
