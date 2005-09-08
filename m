Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVIHI6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVIHI6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVIHI6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:58:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9446 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932412AbVIHI6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:58:32 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
Date: Thu, 8 Sep 2005 10:57:02 +0200
User-Agent: KMail/1.8
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
References: <431FB5FF.1030700@comcast.net> <431FC7DA.6090309@comcast.net> <20050908014436.6edd2f53.akpm@osdl.org>
In-Reply-To: <20050908014436.6edd2f53.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509081057.02583.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 10:44, Andrew Morton wrote:
> Parag Warudkar <kernel-stuff@comcast.net> wrote:
> > Andi Kleen wrote:
> >  >Hmm - not many x86-64 patches in mm1. 2.6.13 definitely works.
> >
> >  2.6.13-git7 works. So something in -mm has gone bad (if not x86_64, may
> >  be i386 or arch-independent changes?)
> >  It seems it has got something to do with the sys_set_tid_address as
> >  evident from the strace output below.
> >  Another thing - If I set LD_ASSUME_KERNEL=2.4 and then run the binary,
> >  it works fine.
>
> I can't reproduce this with the current -mm lineup.  I compiled up a 32-bit
> app on x86 and transferred that across.

Did you use a threaded program?  It appears to be related to that.

(BTW you can compile 32bit on 64bit too by passing -m32) 

-Andi
