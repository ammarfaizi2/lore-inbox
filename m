Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTE2G6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 02:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTE2G6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 02:58:31 -0400
Received: from bay1-dav69.bay1.hotmail.com ([65.54.244.204]:6161 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261936AbTE2G63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 02:58:29 -0400
X-Originating-IP: [129.42.208.139]
X-Originating-Email: [anand_km@hotmail.com]
From: "Anand K" <anand_km@hotmail.com>
To: "Nir Livni" <nirl@cyber-ark.com>
Cc: <linux-kernel@vger.kernel.org>
References: <E1298E981AEAD311A98D0000E89F45134B5694@ORCA>
Subject: Re: fork() crashes on child but returns success on parent
Date: Thu, 29 May 2003 12:43:42 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <BAY1-DAV69IvUtyBMFA000218dd@hotmail.com>
X-OriginalArrivalTime: 29 May 2003 07:11:46.0439 (UTC) FILETIME=[90BF2170:01C325B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering if you have masked off this signal, even though you have
setup signal handlers.

thanks,
Anand K.
----- Original Message -----
From: "Nir Livni" <nirl@cyber-ark.com>
Newsgroups: mailinglists.external.linux-kernel
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, May 28, 2003 5:08 PM
Subject: fork() crashes on child but returns success on parent


> Now I know for sure that the child crashes (SIGSEGV) before fork()
returns.
> I could see it in the UML debugger.
> It does not use the signal handler I have set up of the SIGSEGV. It simply
> crashes and exits.
>
> Could this be any kernel problem ?
> Any ideas what should I do next to track this problem ?
>
> > Subject: fork() returns on parent but not returns on child
> >
> >
> > Hi all,
> > I am experiencing a problem, where fork() returns succesfully
> > on parent, but does not return on child. The child process
> > simply "disappears". I believe it might have got a SIGSEGV
> > (if it makes any sence) before fork() has returned.
> >
> > I would like to track down this problem.
> > What I did so far is:
> > 1. I tried first to make sure there are no memory overruns
> > using few tools. 2. I tried to look at strace output, but the
> > problem does not occur if I use strace 3. I make a
> > UserModeLinux machine and now I would like to breakpoint the
> > created child before it crashes (assuming it really crashes)
> >
> > How do I do that ?
> >
> > Thanks,
> > Nir
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
