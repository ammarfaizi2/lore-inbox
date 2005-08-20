Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVHTPgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVHTPgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 11:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHTPgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 11:36:32 -0400
Received: from mail.gmx.de ([213.165.64.20]:42379 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932332AbVHTPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 11:36:32 -0400
X-Authenticated: #1172751
From: Rainer Koenig <Rainer.Koenig.Usenet@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SATA status report updated
References: <4DbcF-8ux-3@gated-at.bofh.it> <4DbcG-8ux-5@gated-at.bofh.it>
	<4DbcF-8ux-1@gated-at.bofh.it> <4DjWG-4ea-19@gated-at.bofh.it>
	<4Do9X-1IZ-5@gated-at.bofh.it> <4Dp62-304-15@gated-at.bofh.it>
Date: Sat, 20 Aug 2005 17:36:29 +0200
In-Reply-To: <4Dp62-304-15@gated-at.bofh.it> (Jeff Garzik's message of "Sat,
 20 Aug 2005 02:10:10 +0200")
Message-ID: <87r7co4o3m.fsf@Rainer.Koenig.Abg.dialin.t-online.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Jeff Garzik <jgarzik@pobox.com> writes:

> Here is a list of problems with the patch.  I'll paste this into the
> bug as well:

[Lot of interesting issues]

> 8) The DMA pad code is very buggy.  It uses the dma_map_single() to
> map a buffer, but never synchronizes nor flushes the buffer.  This can
> and will lead to data corruption, particularly on x86-64 platform.

That's very bad since the target platform for that chipset is able
to support AMD64. :-(

>From your comments I've learned that my patch (just the device ID) is
too tiny and the SiS provided patch is doing too much things that it
shouldn't do. How can we find a solution for that? 

Would it make sense that I try to find the "goods" in the SiS patch and
merge them somehow in the actual kernel? But: What kernel shall I take
to do that work? The latest development kernel, the kernel of my 
distribution (whatever this will be, sooner or later it has to work
with all distributions) or just a kernel that is "close" to the patch
from SiS, e.g. 2.6.10? 

As I mentioned before, getting hardware to try out patches wouldn't be
that big deal since I'm located in a PC factory and I can get test 
machines if needed. What would be good tests to e.g. detect the problems
that you mentioned above? Are there hardware specific tests for SATA
hard disks around? I would be very interested in that since testing 
also under Linux will become daily work for me and my colleauges from
the system test department.

Best regards
Rainer (posting from home)
-- 
Please send NO spam to my mail addresses.
