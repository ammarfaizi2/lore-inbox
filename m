Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTI3OKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbTI3OKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:10:21 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:46464 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261512AbTI3OKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:10:12 -0400
Date: Tue, 30 Sep 2003 15:10:14 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309301410.h8UEAEgJ000652@81-2-122-30.bradfords.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030930133113.GC23333@redhat.com>
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk>
 <20030930133113.GC23333@redhat.com>
Subject: Re: your mail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Dave Jones <davej@redhat.com>:
> On Tue, Sep 30, 2003 at 09:17:16AM +0100, John Bradford wrote:
>  
>  > Of course a kernel compiled strictly for 386s may seem to boot on an
>  > Athlon but not work properly.  So what?  Just don't run the 'wrong'
>  > kernel.
> 
> Wrong answer. How do you intend to install Linux when a distro boot
> kernel is compiled for lowest-common-denominator (386), and is the
> 'wrong' kernel for an Athlon ?

I don't.  I *never* suggested doing that.  I clearly said a kernel
compiled *strictly* for 386s.  I.E. Without support for other
processors.

> We hashed this argument out a week or so ago, it seems the message
> didn't get across. YOU CAN NOT DISABLE ERRATA WORKAROUNDS IN A KERNEL
> THAT MAY POSSIBLY BOOT ON HARDWARE THAT WORKAROUND IS FOR.

It seems the message didn't get across to you.

Have you actually looked at Adrian's patch?

*Forget* that 386=lowest-common-denominator.  This
'386=lowest-common-denominator' theme is out of date, and we should be
moving away from it - oh, hang on, that's exactly what Adrian's patch
allows us to do.

A distribution installation kernel needs to boot all supported
hardware - of course it does.  So what?  Just select support for all
the processors in the configurator.  No, don't just select 386,
because 386 doesn't mean 386 and above anymore with Adrian's patch, it
means support 386 and don't bloat the kernel with workarounds for
other processors.  Select *all* processors.  Now you have a nice,
(bloated), kernel that boots on the same hardware that you old '386'
one did.  Fine for installation on diverse hardware.  Rubbish for
performance.

Unless, of course, you object to the possibility that somebody might
go out of their way to compile a 386 specific kernel from source
themselves, then run it on an Athlon.  By chance it will probably
appear to work OK, but won't have the workaround enabled.  So what?
Only somebody who knows exactly what they were doing is likely to do
that - how could it happen by accident?  If you really must, put a
warning in to say, 'This kernel doesn't support your processor', but
doing that just adds more bloat.  OK, so the bloat will be freed after
boot, but it's still bloat on the boot device, which matters in some
embedded systems.

> clearer ?

It's clear that you didn't read my original post, yes.

John.
