Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269696AbUJMNny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbUJMNny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 09:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUJMNny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 09:43:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5569 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269696AbUJMNnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 09:43:52 -0400
Date: Wed, 13 Oct 2004 14:43:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, viro@ZenII.linux.org.uk
Subject: Re: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
Message-ID: <20041013134350.GA23987@parcelfarce.linux.theplanet.co.uk>
References: <c461c0d10410130406714fafe3@mail.gmail.com> <c461c0d104101305103792ad7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c461c0d104101305103792ad7a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 01:10:10PM +0100, Alex Kiernan wrote:
> On Wed, 13 Oct 2004 12:06:29 +0100, Alex Kiernan <alex.kiernan@gmail.com> wrote:
> > I've run into a bug in the UFS reading code (on Solaris x86 the
> > major/minor numbers are in 2nd indirect offset not the first), so I've
> > patched it & bugzilled it
> > (http://bugzilla.kernel.org/show_bug.cgi?id=3475).
> > 
> > But where do I go from here? There doesn't seem to be a maintainer for
> > UFS so I can't send it there.
> > 
> 
> After advice from Alan (thanks), here's the patch which addresses the
> problem I'm seeing. Specifically it appears that on x86 Solaris stores
> the major/minor device numbers in the 2nd indirect block, not the
> first.

1) please, move old_encode_dev()/old_decode_dev() into your helper functions.
2) we could do a bit better now that we have large dev_t.  What are complete
rules for
	a) Solaris userland dev_t => on-disk data
	b) major/minor => Solaris userland dev_t
on sparc and x86 Solaris?
