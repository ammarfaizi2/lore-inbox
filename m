Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030783AbWKOSCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030783AbWKOSCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030787AbWKOSCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:02:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18867 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030783AbWKOSCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:02:04 -0500
Subject: Re: [PATCH] i386-pda UP optimization
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <455B4E2F.7040408@goop.org>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>
	 <1158047806.2992.7.camel@laptopd505.fenrus.org>
	 <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de>
	 <20061115172003.GA20403@elte.hu>  <455B4E2F.7040408@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 19:01:42 +0100
Message-Id: <1163613702.31358.145.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 09:28 -0800, Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> > Eric's test shows a 5% slowdown. That's far from cheap.
> >   
> 
> It seems like an absurdly large difference.  PDA references aren't all
> that common in the kernel; for the %gs prefix on PDA accesses to be
> causing a 5% overall difference in a test like this means that the
> prefixes would have to be costing hundreds or thousands of cycles, which
> seems absurd.  Particularly since Eric's patch doesn't touch head.S, so
> the %gs save/restore is still being executed.


segment register accesses really are not cheap. 
Also really it'll be better to use the register userspace is not using,
but we had that discussion before; could you remind me why you picked 
%gs in the first place?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

