Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWCFT4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWCFT4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbWCFT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:56:29 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:35257 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751256AbWCFT42 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:56:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oi9k3jrKKvJNX/mKsDXYfisg2ZspFX7dUZCDCB4hw0NTA7bCMWho5DXN+lV5yWd6tBRUWKGpACGM4q2sR6KX15TN6UIhpdqeQ1y8kRePCjAnC9AjryqC7qkqp49RnfYa8fcjF1r9slKPsxnK7DBZRHuP+ETN3BGZLs4RPGwrqso=
Message-ID: <41b516cb0603061156n79d1d572n5f376819ad5f3bf4@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:56:28 -0800
From: "Chris Leech" <chris.leech@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Discourage duplicate symbols in the kernel? [Was: Intel I/O Acc...]
Cc: "Sam Ravnborg" <sam@ravnborg.org>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060305011852.368c016e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <4408C2CA.5010909@garzik.org>
	 <41b516cb0603031439n13e4df4cg8e5b21b606d2b4b8@mail.gmail.com>
	 <20060305000933.2d799138.akpm@osdl.org>
	 <20060305090251.GA9116@mars.ravnborg.org>
	 <20060305011852.368c016e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Andrew Morton <akpm@osdl.org> wrote:
> Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > On Sun, Mar 05, 2006 at 12:09:33AM -0800, Andrew Morton wrote:
> >  > > +
> >  > > +static inline u8 read_reg8(struct cb_device *device, unsigned int offset)
> >  > > +{
> >  > > +        return readb(device->reg_base + offset);
> >  > > +}
> >  >
> >  > These are fairly generic-sounding names.  In fact the as-yet-unmerged tiacx
> >  > wireless driver is already using these, privately to
> >  > drivers/net/wireless/tiacx/pci.c.
> >
> >  Do we in general discourage duplicate symbols even if they are static?
>
> Well, it's a bit irritating that it confuses ctags.  But in this case, one
> set is in a header file so the risk of collisions is much-increased.

They're in a header file that's specific to a single driver, so I
don't see where a conflict would occur.  But I didn't think about
ctags, and these can easily be prefixed so I'll go ahead and change
them.

- Chris
