Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUDGWTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDGWTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:19:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11758 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261161AbUDGWTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:19:46 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040407234525.4f775c16.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081374061.9061.26.camel@arrakis>
	 <20040407234525.4f775c16.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081376372.9925.2.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 15:19:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 14:45, Andi Kleen wrote:
> On Wed, 07 Apr 2004 14:41:02 -0700
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
> > On Wed, 2004-04-07 at 14:27, Andi Kleen wrote:
> > > On Wed, 07 Apr 2004 14:24:19 -0700
> > > Matthew Dobson <colpatch@us.ibm.com> wrote:
> > > 
> > > > 	I must be missing something here, but did you not include mempolicy.h
> > > > and policy.c in these patches?  I can't seem to find them anywhere?!? 
> > > > It's really hard to evaluate your patches if the core of them is
> > > > missing!
> > > 
> > > It was in the core patch and also in the last patch I sent Andrew.
> > > See ftp://ftp.suse.com/pub/people/ak/numa/* for the full patches
> > 
> > Ok.. I'll check that link, but what you posted didn't have the files
> > (mempolicy.h & policy.c) in the patch:
> 
> Indeed. Must have gone missing. Here are the files for reference.
> 
> The full current broken out patchkit is in 
> ftp.suse.com:/pub/people/ak/numa/2.6.5mc2/

Server isn't taking connections right now.  At least for me... :(

Your patch still looks broken.  It includes some files twice:

> diff -u linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o linux-2.6.5-mc2-numa/include/linux/mempolicy.h
> --- linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o	2004-04-07 12:07:18.000000000 +0200
> +++ linux-2.6.5-mc2-numa/include/linux/mempolicy.h	2004-04-07 12:07:13.000000000 +0200
> @@ -0,0 +1,219 @@

<snip>

> diff -u linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o linux-2.6.5-mc2-numa/include/linux/mempolicy.h
> --- linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o	2004-04-07 12:07:18.000000000 +0200
> +++ linux-2.6.5-mc2-numa/include/linux/mempolicy.h	2004-04-07 12:07:13.000000000 +0200
> @@ -0,0 +1,219 @@

-Matt

