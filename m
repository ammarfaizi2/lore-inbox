Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264837AbUEEXLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbUEEXLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUEEXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:11:19 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:3004 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264669AbUEEXLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:11:15 -0400
Subject: Re: swsusp documentation updates
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040505101158.GC1361@elf.ucw.cz>
References: <20040505094719.GA4259@elf.ucw.cz>
	 <1083750907.17294.27.camel@laptop-linux.wpcb.org.au>
	 <20040505101158.GC1361@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1083798626.17294.79.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 06 May 2004 09:10:26 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-05-05 at 20:11, Pavel Machek wrote:
> Hi!
> 
> > > +There are two solutions to this:
> > > +
> > > +* require half of memory to be free during suspend. That way you can
> > > +read "new" data onto free spots, then cli and copy
> > 
> > Would you consider adding:
> > 
> > (Suspend2, which allows more than half of memory to be saved, is a
> > variant on this).
> 
> How would you like this added?
> 
> swsusp2 shares this fundamental limitation, but does not include user
> data and disk caches into "used memory" by saving them in
> advance. That means that limitation goes away in practice.

That sounds good. I'd include that.

> And perhaps you want to write "What is swsusp2?" question/answer?

How does this sound?...

What is 'swsusp2'?

swsusp2 is Software Suspend 2, forked implementation of suspend-to-disk
which is available as separate patches for 2.4 and 2.6 kernels from
swsusp.sourceforge.net. It includes support for SMP, 4GB Highmem and
preemption. It also has a extensible architecture that allows for
arbitrary transformations on the image (compression, encryption) and
arbitrary backends for writing the image (eg to swap or an NFS
share[Work In Progress]). Questions regarding suspend2 should be sent to
the mailing list available through the Suspend2 website, and not to the
Linux Kernel Mailing List. We are working toward merging Suspend2 into
the mainline kernel.
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

