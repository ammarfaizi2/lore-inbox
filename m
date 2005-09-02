Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbVIBWer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVIBWer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbVIBWer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:34:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161086AbVIBWeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:34:46 -0400
Date: Fri, 2 Sep 2005 15:34:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
       torvalds@osdl.org
Subject: Re: FUSE merging?
Message-Id: <20050902153440.309d41a5.akpm@osdl.org>
In-Reply-To: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Hi Andrew!
> 
> Do you plan to send FUSE to Linus for 2.6.14?

Haven't thought about it all much.  Have spent most of my time in the last
month admiring the contents of kernel bugzilla, and the ongoing attempts to
increase them.

> I know you have some doubts about usefulness, etc.  Here are a couple
> of facts, that I hope show that Linux should benefit from having FUSE:
> 
>  - total number of downloads from SF: ~25000
> 
>  - number of downloads of last release (during 3 months): ~7000
> 
>  - number of distros carrying official packages: 2 (debian, gentoo)
> 
>  - number of publicly available filesystems known: 27
> 
>  - of which at least 2 are carried by debian (and maybe others)
> 
>  - number of language bindings: 7 (native: C, java, python, perl, C#, sh, TCL)
> 
>  - biggest known commercial user: ~110TB exported, total bandwidth: 1.5TB/s
> 
>  - mailing list traffic 100-200 messages/month
> 
>  - have been in -mm since 2005 january
> 

I agree that lots of people would like the functionality.  I regret that
although it appears that v9fs could provide it, there seems to be no
interest in working on that.

The main sticking point with FUSE remains the permission tricks around
fuse_allow_task().  AFAIK it remains the case that nobody has come up with
any better idea, so I'm inclined to merge the thing.
