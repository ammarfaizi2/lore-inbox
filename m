Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWEVLvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWEVLvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWEVLvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:51:46 -0400
Received: from mail.suse.de ([195.135.220.2]:47245 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750780AbWEVLv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:51:29 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, roland@redhat.com, anemo@mba.ocn.ne.jp,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       Aleksey_Gorelov@Phoenix.com
Subject: Re: [PATCH] fix broken vm86 interrupt/signal handling
References: <0EF82802ABAA22479BC1CE8E2F60E8C3EECE1B@scl-exch2k3.phoenix.com>
	<1148092188.3069.6.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2006 13:25:26 +0200
In-Reply-To: <1148092188.3069.6.camel@laptopd505.fenrus.org>
Message-ID: <p7364jy713t.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

D> On Fri, 2006-05-19 at 15:09 -0700, Aleksey Gorelov wrote:
> > Hi,
> > 
> >   This patch
> > www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h
> > =c3ff8ec31c1249d268cd11390649768a12bec1b9 has broken vm86
> > interrupt/signal handling in case when vm86 is called from kernel space.
> 
> can you point out where vm86 is called from kernel space?

Programs inside vm86 can run with segments that look like ring 0.
That is why i386 always checks (ring > 0 || vmmask in eflags) when it checks
for user mode.

I guess Aleksey meant that.

-Andi
