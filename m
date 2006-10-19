Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161446AbWJSPL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161446AbWJSPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWJSPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:11:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47823 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161446AbWJSPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:11:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Undeprecate the sysctl system call
References: <453519EE.76E4.0078.0@novell.com>
	<20061017091901.7193312a.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	<1161123096.5014.0.camel@localhost.localdomain>
	<20061017150016.8dbad3c5.akpm@osdl.org>
	<Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
	<m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
	<1161169330.9363.11.camel@localhost.localdomain>
Date: Thu, 19 Oct 2006 09:09:45 -0600
In-Reply-To: <1161169330.9363.11.camel@localhost.localdomain> (Alan Cox's
	message of "Wed, 18 Oct 2006 12:02:10 +0100")
Message-ID: <m1irig5oli.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> The status quo is that we don't properly maintain sysctl.h and we arbitrarily
>> change the numbers.
>
> Not the core basic ones that are those people care about

I agree.  It just appears that the core basic ones that people
care about is the empty set.

And we the kernel developers have made no promises to keep any
of the sysctl values constant.

>From sysctl.h:
>  ****************************************************************
>  ****************************************************************
>  **
>  **  The values in this file are exported to user space via 
>  **  the sysctl() binary interface.  However this interface
>  **  is unstable and deprecated and will be removed in the future. 
>  **  For a stable interface use /proc/sys.
>  **
>  ****************************************************************
>  ****************************************************************

>From the sysctl(2) man page.

> BUGS
>        The object names vary between kernel versions.  THIS MAKES THIS SYSTEM CALL WORTHLESS FOR APPLICATIONS.  Use the
>        /proc/sys interface instead.

The empirical evidence is also that no one uses sysctl, and that no one cares.

Once we can find that one user that really cares we can have serious conversations
about keeping sys_sysctl.

Eric
