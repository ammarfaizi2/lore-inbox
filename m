Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSGCSnF>; Wed, 3 Jul 2002 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSGCSnE>; Wed, 3 Jul 2002 14:43:04 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:64902 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317191AbSGCSnC> convert rfc822-to-8bit; Wed, 3 Jul 2002 14:43:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Hugh Dickins <hugh@veritas.com>, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Rusty's module talk at the Kernel Summit
Date: Wed, 3 Jul 2002 20:46:24 +0200
User-Agent: KMail/1.4.1
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.21.0207031803250.1391-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0207031803250.1391-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207032046.24730.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 3. Juli 2002 19:07 schrieb Hugh Dickins:
> On Wed, 3 Jul 2002, Adam J. Richter wrote:
> > On Wed, 03 Jul 2002 22:27:33 +1000, Keith Owens wrote:
> > >It does not.  There is no code to adjust any tables after discarding
> > >kernel __init sections.  We rely on the fact that the discarded
> > > kernel area is not reused for executable text.
> >
> > 	Come to think of it, if the core kernel's .text.init pages could
> > later be vmalloc'ed for module .text section, then I think you may
> > have found a potential kernel bug.
>
> No: the virtual address (which is what matters) would be different:
> core kernel's .text.init is not in vmalloc virtual address range.

Does that mean that kmalloc cannot be used to load modules?
At least for small modules it would save TLB entries.

	Regards
		Oliver

