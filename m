Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVEFXJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVEFXJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVEFXJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:09:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:19148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261321AbVEFXFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:05:17 -0400
Date: Fri, 6 May 2005 16:05:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: sharada@in.ibm.com
Cc: paulus@samba.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com, fastboot@lists.osdl.org
Subject: Re: [PATCH] ppc64: kexec support for ppc64
Message-Id: <20050506160546.388aeed4.akpm@osdl.org>
In-Reply-To: <20050506124409.GB2741@in.ibm.com>
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com>
	<20050506124158.GA2741@in.ibm.com>
	<20050506124409.GB2741@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R Sharada <sharada@in.ibm.com> wrote:
>
> This patch implements the kexec support for ppc64

Well that's pretty neat.   How well does this work?

I assume you'll be working on kdump-via-kexec for ppc64?


This kdump/kexec stuff has been hanging around for far too long, IMO.  I'd
like to think about what we can do to get things moving along a bit more.

I have two issues with it:

a) Vague feelings that the low-level ia32 changes may cause APIC/etc
   breakage with some PCs.

b) Much more significantly: I still do not believe that it has been
   demonstrated that the whole kdump-via-kexec scheme will have a
   sufficiently high success rate for this to become Linux's way of doing
   crashdumps.

   And it would not be good if in six months time we decide that the
   practical problems in getting it all working sufficiently well are
   insurmountable and we have to revert it all and start working on
   something else.

   Recently I've seem a couple of "kdump worked for me" reports, which are
   greatly appreciated, but I don't think they're statistically
   significant.

   So am I right to have this concern?  If so, how can we settle this? 
   (ie: who's going to do it?  ;))


Perhaps we could declare that kexec is sufficiently useful and mature in
its own right and just merge up those bits while we work on kdump.  This
also gives us a bit of pipelining: continue to test and stabilise kexec
while kdump remains in development.

Opinions are sought...
