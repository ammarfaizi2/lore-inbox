Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319192AbSHNEQa>; Wed, 14 Aug 2002 00:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319194AbSHNEQa>; Wed, 14 Aug 2002 00:16:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40907 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319192AbSHNEQ3>;
	Wed, 14 Aug 2002 00:16:29 -0400
Date: Wed, 14 Aug 2002 00:20:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
In-Reply-To: <20020814000727.C15947@redhat.com>
Message-ID: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Aug 2002, Benjamin LaHaise wrote:

> On Tue, Aug 13, 2002 at 09:11:55PM -0700, Andrew Morton wrote:
> > It requires root.
> 
> Still, unlike kernel code that can be rate limited, this call cannot.  
> Besides, isn't adding yet another syscall that's equivalent to write(2) 
> a reason to take this patch and burn it along with the vomit its caused?

I have a better suggestion.  How about we make write(2) on /dev/console to
act as printk()?  IOW, how about making _all_ writes to console show up in
dmesg?

Then we don't need anything special to do logging _and_ we get output
of init scripts captured.  For free.  dmesg(8) would pick that up, klogd(8)
will work as is, etc.

Linus?

