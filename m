Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUEGGfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUEGGfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 02:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEGGfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 02:35:00 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:56330 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261340AbUEGGe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 02:34:58 -0400
Date: Fri, 7 May 2004 14:42:37 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Paul Jakma <paul@clubi.ie>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux autofs <autofs@linux.kernel.org>
Subject: Re: [autofs] Badness in interruptible_sleep_on
In-Reply-To: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not sure what needs to be done about this Paul.

I eliminated the interruptible_sleep_on in my autofs4 patches long ago. 
The current updates are in 2.6.6-rc3-mm2.

As for autofs4 and 2.4 I have the impression that my changes have little 
chance of being accepted and so haven't put the needed effort into 
preparing them.

However, if you are looking to use the current patches please wait a 
couple of days for the latest update.

On Fri, 7 May 2004, Paul Jakma wrote:

> Hi,
> 
> I regularly get the following in my logs:
> Badness in interruptible_sleep_on at kernel/sched.c:1923
> Call Trace:
> 
>  [<c0120c9f>] interruptible_sleep_on+0x5a/0x230
>  [<c01205a7>] default_wake_function+0x0/0xc
>  [<d08ea491>] autofs4_wait+0x35d/0x509 [autofs4]
>  [<c01c33dd>] inode_has_perm+0x57/0x5f
>  [<d08e8572>] try_to_fill_dentry+0x39/0x25c [autofs4]
>  [<c0173b4c>] do_lookup+0x54/0x72
>  [<c01740e9>] link_path_walk+0x57f/0xcb1
>  [<c0174b7d>] __user_walk+0x21/0x36
>  [<c016f1ad>] vfs_lstat+0x11/0x37
> 
> regards,
> -- 
> Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
> 	warning: do not ever send email to spam@dishone.st
> Fortune:
> Interchangeable parts won't.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 

