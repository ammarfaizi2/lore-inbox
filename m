Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWFFP2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWFFP2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFFP2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:28:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5897 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S932219AbWFFP2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:28:16 -0400
Date: Tue, 6 Jun 2006 15:20:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Message-ID: <20060606152041.GA5427@ucw.cz>
References: <20060604135011.decdc7c9.akpm@osdl.org> <448366FB.1070407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448366FB.1070407@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >git-klibc.patch
> >
> > Similar.  This all appears to work sufficiently well 
> > for a 2.6.18 merge. But it's been so long since klibc 
> > was a hot topic that I've forgotten who
> > wanted it, and what for.
> >
> > Can whoever has an interest in this work please pipe 
> > up and let's get our
> > direction sorted out quickly.
> >
> 
> klibc (early userspace) in its current form is 
> fundamentally a cleanup. What it does is unload code 
>  from the kernel which has no fundamental reason to be 
> kernel code (written during kernel rules, with all the 
> problems it entails.)  The initial code to have removed 
> is the root-mounting code, with all the various ugly 
> mutations of that (ramdisk loading, NFS root, initrd...)
> 
> The original idea was due Al Viro; obviously, the 
> implementation is mostly mine.
> 
> It is of course my hope that this will be used for more 
> than just plain initialization code, but that in itself 
> is a significant step, and one has to start somewhere.

It allows me to unify swsusp & uswsusp into one in future, for
example, reducing code duplication. klibc looks like good thing.

-- 
Thanks for all the (sleeping) penguins.
