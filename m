Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbULFAHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbULFAHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbULFAHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:07:07 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:53156
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261428AbULFAHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:07:00 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 5 Dec 2004 18:05:20 -0500
User-Agent: KMail/1.6.2
Cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       Mariusz Mazur <mmazur@kernel.pl>, Arjan van de Ven <arjanv@redhat.com>,
       andersen@codepoet.org
References: <19865.1101395592@redhat.com> <41B30AF2.6060505@dgreaves.com> <20041205155743.GA24304@pclin040.win.tue.nl>
In-Reply-To: <20041205155743.GA24304@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412051805.20980.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Trimming linus from cc: list because he asked.)

On Sunday 05 December 2004 10:57 am, Andries Brouwer wrote:
> On Sun, Dec 05, 2004 at 01:19:46PM +0000, David Greaves wrote:
> > Err,
> >
> > Isn't this WRONG.
>
> You did not read my mail, or you did not understand it.
>
> Please write the patch for losetup to avoid looking at kernel source.
> If you after writing think that it is cleaner than the present setup,
> submit it.

Avoiding looking at the kernel source for the darn structure would be 
relatively easy if the thing didn't vary by architecture.  I agree that 
hardwiring into userspace code #ifdefs for ARE_WE_ON_ALPHA is approximately 
as ugly as hardwiring in #ifdefs for IS_THIS_2.6.

Both are ugly.  This is why header files exist.  I still don't understand why 
we're not supposed to use 'em when the alternative is building incestuous 
knowledge about the kernel version we're compiling against into our 
application.

Bluntlly, I don't understand why "#include <linux/version.h>" and several 
#ifdefs is an improvement on "#include <linux/loop.h>" with no #ifdefs.

Rob
