Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271244AbTHCVep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbTHCVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:34:45 -0400
Received: from [209.195.52.120] ([209.195.52.120]:46761 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S271244AbTHCVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:34:43 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, devik@cdi.cz
Date: Sun, 3 Aug 2003 14:33:01 -0700 (PDT)
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from
 being modified easily
In-Reply-To: <20030803140031.7665546c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308031425100.24695-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Andrew Morton wrote:

> bert hubert <ahu@ds9a.nl> wrote:
> >
> > as one of the 'tastemasters', what are your thoughts on doing this
> > dynamically? The sigsegv option might be a dynamic option?
>
> who, me?  umm...
>
> I can see that a patch like this would have a place in a general
> security-hardened kernel: one which closes off all the means by which root
> can alter the running kernel.
>
> But that's a specialised thing which interested parties can maintain as a
> standalone patch, and bringing just one part of it into the main kernel
> seems rather arbitrary.

why not bring the other parts in as options as well?

I can understand not bringing in all the external security modules that
want to regulate access to everything else (full capabilities, etc) but
locking down the kernel itself to prevent it from being modified seems
like something that would have a place on most servers, possibly also on
desktops that aren't dynamicly adding hardware (probably not that useful
for many laptop users for this reason)

we already have the option to not support modules (as Alan Cox points out
every time that subject comes up it can be bypassed by people who have
access to /dev/*mem) so it would seem that adding the option to bar access
to /dev/*mem as well would make exisitng config options mean what they
appear to mean.

David Lang

