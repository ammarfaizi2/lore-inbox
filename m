Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbTFLXeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFLXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:34:09 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:9626 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265057AbTFLXeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:34:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 12 Jun 2003 16:45:51 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Patrick Mochel <mochel@osdl.org>
cc: Robert Love <rml@tech9.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
Message-ID: <Pine.LNX.4.55.0306121645290.3626@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, Patrick Mochel wrote:

>
> > > +	spin_lock(&sequence_lock);
> > > +	seq = sequence_num++;
> > > +	spin_unlock(&sequence_lock);
> > > +
> > > +	envp [i++] = scratch;
> > > +	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
> >
> > Nice thinking. It is a shame we need a lock for this, but we don't have
> > an atomic_inc_and_return().
>
> Those were my sentiments exactly:
>
> 16:21  * mochel searches for atomic_inc_and_read() :)
>
> It seems like the following should work. Would someone mind commenting on
> it?

It does not Pat, look at the generated asm.



- Davide

