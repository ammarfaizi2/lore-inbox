Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289995AbSAWTVe>; Wed, 23 Jan 2002 14:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSAWTVY>; Wed, 23 Jan 2002 14:21:24 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:60301 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289977AbSAWTVT>; Wed, 23 Jan 2002 14:21:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: "David S. Miller" <davem@redhat.com>, drobbins@gentoo.org
Subject: Re: Athlon/AGP issue update
Date: Wed, 23 Jan 2002 20:20:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1011779573.9368.40.camel@inventor.gentoo.org> <20020123.021819.21955581.davem@redhat.com>
In-Reply-To: <20020123.021819.21955581.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16TSwv-1txQjwC@fwd08.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 January 2002 11:18, David S. Miller wrote:
> This means that the fix belongs in the DRM drivers, specifically
> DRM(mmap_dma) should clear the cacheability bits in the
> vma->vm_page_prot at mmap time.

Is that sufficient ? Must the cache be flushed explicitely ?

[..]
> Disabling 4MB translations has zero effect on the problem they say is
> the root all of this.  The mappings given to the OpenGL driver to the
> GART memory is still going to be cacheable, thus the problem ought to
> still exist.
>
> As usual, AMD's commentary brings more questions than it answers.

Perhaps speculative writes require an entry in the TLB making it less likely 
that they'll happen to 4KB pages.

	Regards
		Oliver
