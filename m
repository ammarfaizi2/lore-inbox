Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTI3JvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTI3JvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:51:03 -0400
Received: from ns.suse.de ([195.135.220.2]:43716 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261304AbTI3JvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:51:01 -0400
To: Gabriel Paubert <paubert@iram.es>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
References: <20030929125629.GA1746@averell.suse.lists.linux.kernel>
	<20030929170323.GC21798@mail.jlokier.co.uk.suse.lists.linux.kernel>
	<20030929174910.GA90905@colin2.muc.de.suse.lists.linux.kernel>
	<20030929200820.GA23444@mail.jlokier.co.uk.suse.lists.linux.kernel>
	<20030930093556.GB12970@iram.es.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Sep 2003 11:50:53 +0200
In-Reply-To: <20030930093556.GB12970@iram.es.suse.lists.linux.kernel>
Message-ID: <p73fziey58i.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert <paubert@iram.es> writes:

> On Mon, Sep 29, 2003 at 09:08:20PM +0100, Jamie Lokier wrote:
> > Btw, you assume that regs->xcs is a valid segment value.  I think that
> > the upper 16 bits are not guaranteed to be zero in general on the
> > IA32, although they clearly are zero for the majority of IA-32 chips.
> > Are they guaranteed to be zero on AMD's processors?
> 
> At least for pushes of segment registers a 486 decrements
> the stack pointer by 4 but only writes the 2 least significant
> bytes, leaving garbage in the upper half. 

The code only runs on newer AMD CPUs (K7/K8)

-Andi
