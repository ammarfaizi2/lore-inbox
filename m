Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJUQkb>; Mon, 21 Oct 2002 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJUQkb>; Mon, 21 Oct 2002 12:40:31 -0400
Received: from hplb.hpl.hp.com ([192.6.10.2]:22796 "EHLO hplb.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261525AbSJUQk2>;
	Mon, 21 Oct 2002 12:40:28 -0400
Message-ID: <007801c27921$28e1bf00$6345900f@hpl.hp.com>
From: "Mike Wray" <mike_wray@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Stephen Smalley" <sds@tislabs.com>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
References: <Pine.GSO.4.33.0210181239310.9847-100000@raven> <003701c27909$7367e350$6345900f@hpl.hp.com> <20021021150920.A14396@infradead.org>
Subject: Re: [PATCH] remove sys_security
Date: Mon, 21 Oct 2002 17:44:15 +0100
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


From: Christoph Hellwig <hch@infradead.org>
Sent: 21 October 2002 15:09
> On Mon, Oct 21, 2002 at 02:54:33PM +0100, Mike Wray wrote:
> > I'm not sure the case for removal has been made. Some potential problems
> > with the LSM security syscall have been pointed out. Isn't it better to
> > consider
> > fixes instead of ditching the syscall?
>
> The conceptual wrong design was pointed out, yes.  It's not fixable
> without rplacing it with a proper design of the security module entry
> points.
>

I'm not sure what was conceptually wrong. There are other multiplexing
syscalls
in the kernel - so the concept of multiplexing cannot be wrong?
Or is setsockopt broken too?

If it's just the particular signature used
right now that's the problem, then that's easily fixed.

For example, what would be wrong in making the security syscall follow the
get/set sockopt approach?

> > Won't the absence of the syscall just result
> > in even worse code being used? Presumably SELinux will have to implement
> > the syscall functionality some other way.
>
> Unlike this hook there is a chance we can review their new creations when
> they ask for inclusion.

Netfilter provides nf_register_sockopt() to allow open-ended registration
of socket-opt handling by a module - without any review. So do many other
kernel interfaces.

Mike

