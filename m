Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUHQFMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUHQFMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHQFMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:12:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:12233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268114AbUHQFMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:12:05 -0400
Date: Mon, 16 Aug 2004 22:10:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: jdike@addtoit.com, kai@germaschewski.name, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-Id: <20040816221017.018b0ef9.akpm@osdl.org>
In-Reply-To: <20040817050642.GK11200@holomorphy.com>
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
	<20040815150635.5ac4f5df.akpm@osdl.org>
	<200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
	<20040817050642.GK11200@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Tue, Aug 17, 2004 at 02:02:21AM -0400, Jeff Dike wrote:
> > The undefined symbol checking is continuing to cause UML pain.  This time,
> > it picked up a bunch of 'w' symbols as undefined.  They were present in the
> > 2.6.8-rc4-mm1 vmlinux and caused no problems for the final link, so I added
> > them as a second special case to mksysmap (and I just noticed that I forgot
> > a comment there - I can submit a patch for that if there's demand for one).
> 
> Likewise for sparc64; the 'w' symbols are showing up as 'undefined'
> there too. Probably because [^w] isn't behaving as expected.
> 

Sigh.  That patch is causing a ton of grief.  But Russell's reasons for
needing it on ARM were solid, and it is a bit weird for any architecture to
have undefined symbols in vmlinux.  I guess we persist.

