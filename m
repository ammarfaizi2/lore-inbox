Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTDGGeG (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTDGGeG (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:34:06 -0400
Received: from dp.samba.org ([66.70.73.150]:60886 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263277AbTDGGeF (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 02:34:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC 
Date: Mon, 07 Apr 2003 16:45:33 +1000
Message-Id: <20030407064541.4E1312C04E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <20030407072144.A28096@infradead.org> you wrote:
> On Mon, Apr 07, 2003 at 03:09:37PM +1000, Paul Mackerras wrote:
> > Anyway, it's not your call.
> 
> if you look at MAINTAINERS I'm responsible for personality handling, so
> maybe it actually _is_ my call?

Which simply shows that an entry in the MAINTAINERS file does not a
maintainer make, since your first post showed such misundestanding of
what personalities do, and you've let the 2.4 and 2.5 personality
lists get out of sync.

Qemu could hack it into all the stat, stat64, open, chmod, chown,
link, rename etc. calls in the emulator, yes, but the in-kernel
solution already exists and is far simpler.

> Because stuff should go into 2.5 first.

I happens, though, whatever you may think.  It was done as a 2.4 patch
because there's a tighter time constraint on entry into 2.4.

> And even if it looks trivial there's an important policy decision
> here: do we want to clutter up our personality system for userspace
> emulators?  If you look at the current list of personalities they
> all have kernel implementations

This is not qemu specific, of course.  If you say it's not going in,
then I'll accept that and do the work inside qemu.  It'll be damn
slow, of course.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
