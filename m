Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTJDH4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTJDH4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:56:46 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:38075 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261932AbTJDH4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:56:44 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: down_timeout
Date: Sat, 4 Oct 2003 09:53:43 +0200
User-Agent: KMail/1.5.4
References: <F760B14C9561B941B89469F59BA3A84702C93004@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C93004@orsmsx401.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040953.43024.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Friday 03 October 2003 20:03, Grover, Andrew wrote:
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> > Matthew Wilcox
> > It's still not great because it doesn't preserve ordering.
> > down_timeout()
> > would be a much better primitive.  We have down_interruptible() which
> > could be used for this purpose.  Something like (completely
> > uncompiled):
>
> Yeah we proposed this 2 years ago and someone (don't remember who) shot
> us down.

It was me.

Reason: 
	I misunderstood your suggestion down_timeout() as "down and hold
	a semaphore until timeout" instead of "try until timeout to get
	the semaphore". I suggested using waitqueues for this.

But now that I understand, what you really want, I agree that this is
very useful and also agree that the kernel should provide it.

I don't think that I prevented it from being accepted, but my opinion
about it might had have the wrong influence.

I'm really sorry, that this simple communication problem caused you,
the ACPI development and users such a big pain.

PS: And I still think that semaphores with a maximum hold time are a bad
    idea in the linux kernel. But this is just *my* opinion ;-)

Regards

Ingo Oeser


