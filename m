Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSJUNvV>; Mon, 21 Oct 2002 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbSJUNvV>; Mon, 21 Oct 2002 09:51:21 -0400
Received: from hplb.hpl.hp.com ([192.6.10.2]:48399 "EHLO hplb.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261418AbSJUNvU>;
	Mon, 21 Oct 2002 09:51:20 -0400
Message-ID: <003701c27909$7367e350$6345900f@hpl.hp.com>
From: "Mike Wray" <mike_wray@hp.com>
To: "Stephen Smalley" <sds@tislabs.com>,
       "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-security-module@wirex.com>
References: <Pine.GSO.4.33.0210181239310.9847-100000@raven>
Subject: Re: [PATCH] remove sys_security
Date: Mon, 21 Oct 2002 14:54:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Stephen Smalley <sds@tislabs.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>; <linux-security-module@wirex.com>
Sent: 18 October 2002 18:15
Subject: Re: [PATCH] remove sys_security


>
> On Fri, 18 Oct 2002, Christoph Hellwig wrote:
>
> > It adds infrastructure to implement syscalls without peer review.
> > And then it ends being crap like the selinux syscalls.
>
> Yes, I think you've made your point.  Go ahead, remove sys_security.
> We can look into revising the SELinux syscalls, hopefully with some
> constructive suggestions from people, to make them more acceptable.
> Feel free to send specific suggestions, or at least explain further why
> you hate the current ones.
>

I'm not sure the case for removal has been made. Some potential problems
with the LSM security syscall have been pointed out. Isn't it better to
consider
fixes instead of ditching the syscall? Won't the absence of the syscall just
result
in even worse code being used? Presumably SELinux will have to implement
the syscall functionality some other way.

> > And exactly these hooks harm.  They are all over the place, have
performance
> > and code size impact and mess up readability.  Why can't you just
maintain
> > an external patch like i.e. mosix folks that nead similar deep changes?
>
> LSM only came into existence based on Linus' statements about what he
> would be willing to consider for inclusion in the mainstream kernel.  Of
> course, if LSM has diverged from Linus' expectations, then that divergence
> should be corrected.  But that doesn't mean that LSM should be dropped out
> entirely, just pruned and refined.  If the whole of LSM has to be
> maintained as a separate patch, then the various security projects have
> largely wasted their time transitioning to it.
>

Precisely. The whole reason for having LSM at all is that maintaining a
kernel
patch to add a security model is not sustainable. Adding a general kernel
framework to support security was the agreed way to go, and that is what
LSM does.

After the latest changes the LSM framework hurts no-one who
isn't using it, so I see no reason to ditch it. If there are
remaining problems let's fix them - not ditch the approach.

Mike


