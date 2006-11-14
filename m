Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755394AbWKNCw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbWKNCw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbWKNCw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:52:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:56028 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755394AbWKNCw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:52:58 -0500
From: Andi Kleen <ak@suse.de>
To: Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] x86_64: fix perms/range of vsyscall vma in /proc/*/maps
Date: Tue, 14 Nov 2006 03:52:54 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611140251.kAE2pm0Z015391@pasta.boston.redhat.com>
In-Reply-To: <200611140251.kAE2pm0Z015391@pasta.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140352.54669.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 03:51, Ernie Petrides wrote:
> On Friday, 10-Nov-2006 at 6:07 +0100, Andi Kleen wrote:
> 
> > On Friday 10 November 2006 02:20, Ernie Petrides wrote:
> >
> > > Hi, Andi.  The final line of /proc/<pid>/maps on x86_64 for native 64-bit
> > > tasks shows an incorrect ending address and incorrect permissions.  There
> > > is only a single page mapped in this vsyscall region, and it is accessible
> > > for both read and execute.
> > 
> > The range reported is how much address space is reserved, but you're
> > right it is less.
> > 
> > But I don't like hardcoding a page here -- this will likely be extended
> > soon. Can you please create a new define VSYSCALL_REAL_LENGTH or similar 
> > in vsyscall.h and use that?
> 
> Good idea -- how about the patch below?

Added thanks. Probably for .20, i don't think it's critical enough for .19
unless someone feels strongly about it.

-Andi

P.S.: When you retransmit patches please always include the original description
for the changelog too.
