Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVC2IFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVC2IFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVC2IEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:04:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:53156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262179AbVC2IDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:03:04 -0500
Date: Tue, 29 Mar 2005 00:02:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
Message-Id: <20050329000239.6346d73e.akpm@osdl.org>
In-Reply-To: <42490763.5010008@pobox.com>
References: <200503290533.j2T5XEYT028850@hera.kernel.org>
	<4248FBFD.5000809@pobox.com>
	<20050328230830.5e90396f.akpm@osdl.org>
	<20050329071210.GA16409@havoc.gtf.org>
	<20050328232359.4f1e04b9.akpm@osdl.org>
	<42490763.5010008@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >> > Was cc'ed to linux-net last Thursday, but it looks like the messages was
> >> > too large and the vger server munched it.
> >>
> >> This also brings up a larger question... why was a completely unreviewed
> >> net driver merged?
> > 
> > 
> > Because nobody noticed that it didn't make it to the mailing list,
> > obviously.
> 
> That's ducking the question.  Let me rephrase.
> 
> Why was a complete lack of response judged to be an ACK?

That's not uncommon.  I don't ask people "are you reading the mailing list
which you should be reading" unless I think it's someone who doesn't read
the mailing lists which they should be reading.

> For new drivers, that's a -horrible- precedent.  You are quite skilled 
> at poking random hackers :)  why not poke somebody to ack a new drivers? 

In this case I didn't think about it very hard, sorry - figured it was s390
stuff and it hence falls under the "if it breaks, it's the s390 team's
problem" exemption.

>   It's not like this driver (or many of the other new drivers) 
> desperately need to get into the kernel ASAP, so desperate that a lack 
> of review was OK.

True.  But it's not as if we can't fix stuff up after it's merged up.  The
reasons for holding off on a merge would be:

a) We're not sure that the feature should be merged at all

b) Holding off on a merge is a tool we use to motivate the submitter to
   fix the code up

c) The merge breaks existing stuff.

I don't think any of those things apply here.  The only downside is the
increased bk patch volume.

That being said, if there had been review comments I would have delayed the
merge.

