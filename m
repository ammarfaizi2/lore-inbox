Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319193AbSHNEHD>; Wed, 14 Aug 2002 00:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319192AbSHNEHD>; Wed, 14 Aug 2002 00:07:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58045 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319193AbSHNEHB>;
	Wed, 14 Aug 2002 00:07:01 -0400
Date: Wed, 14 Aug 2002 00:10:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
In-Reply-To: <20020813235803.A15947@redhat.com>
Message-ID: <Pine.GSO.4.21.0208140010290.3712-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Aug 2002, Benjamin LaHaise wrote:

> On Tue, Aug 13, 2002 at 08:18:18PM -0700, Andrew Morton wrote:
> > 
> > The patch allows userspace to issue printk's, via sys_syslog():
> 
> This is an incredibly bad idea.  It has security hole written all over it.  
> Any user can now spam the kernel's log ringbuffer and overrun potentially 
> important messages.

He does capability checks there...

