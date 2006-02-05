Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWBEURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWBEURW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBEURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:17:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:5784 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750715AbWBEURV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:17:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 4/4] firewire: add mem1394
References: <1138919238.3621.12.camel@localhost>
	<1138920185.3621.24.camel@localhost>
	<20060205004327.78926498.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 05 Feb 2006 21:17:11 +0100
In-Reply-To: <20060205004327.78926498.akpm@osdl.org>
Message-ID: <p73lkwplfw8.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Johannes Berg <johannes@sipsolutions.net> wrote:
> >
> > +config IEEE1394_MEMDEV
> > +	tristate "IEEE1394 memory device support"
> > +	depends on IEEE1394 && EXPERIMENTAL
> > +	help
> > +	  Say Y here if you want support for the ieee1394 memory device.
> > +	  This is useful for debugging systems attached via firewire
> > +	  since it usually allows you to read from and write to their memory,
> > +	  depending on the controller and machine setup.
> 
> 1394 is evil.  Does this mean that if a machine is completely
> dead-and-crashed, we can still suck all its memory out over 1394 with no
> cooperation from the dead machine's kernel?  If not, what limitations are
> there?

Yes it can. BenH's firescope tool does this already using raw1394
(I have it working now on x86-64 too). I dont quite see the point
of adding another kernel driver for it though. This can be all
done fine in userspace.

-Andi
