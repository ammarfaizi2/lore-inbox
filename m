Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUAMHkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 02:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAMHkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 02:40:04 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:40975 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261368AbUAMHj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 02:39:58 -0500
Date: Tue, 13 Jan 2004 15:39:41 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jeff Garzik <jgarzik@pobox.com>, "H. Peter Anvin" <hpa@zytor.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <4002D1E8.1010407@sun.com>
Message-ID: <Pine.LNX.4.33.0401131535250.15712-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.6, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Mike Waychison wrote:

> Jeff Garzik wrote:
>
> >
> >
> > You're still using arguments -against- putting software in the kernel.
> > You don't decrease software's chances of "being broken" by putting it
> > in the kernel, the opposite occurs -- you increase the likelihood of
> > making the entire system unstable.  This is one point that Solaris and
> > Win32 have both missed :)
> >
> >     Jeff
> >
> I get what you're saying. :)
>
> However, doing so achieves two goals:
>     - I want kernelspace to provide mechanism, and let userspace define
> policy. In this case, the policy is even finer grained than what we had
> before and can be set at trigger time, rather than at initscript start time.
>     - I want to get rid of the old ioctl poll interface that didn't work
> in namespaces.
>
> The namespace problem effectively limits what we can do in userspace to
> simply prodding the kernel to tell _it_ to unmount stuff.  A daemon
> alone cannot unmount across namespaces.

Another important consideration is "can implementing this functionality be
significanly simplified by doing it within the kernel" or if
functionality is not otherwise able to be done in userspace. I believe
that these points were made in the original proposal.

Ian




