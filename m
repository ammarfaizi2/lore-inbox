Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283510AbRLDVja>; Tue, 4 Dec 2001 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283509AbRLDVjU>; Tue, 4 Dec 2001 16:39:20 -0500
Received: from zero.tech9.net ([209.61.188.187]:55044 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283479AbRLDVjE>;
	Tue, 4 Dec 2001 16:39:04 -0500
Subject: Re: [PATCH] improve spinlock debugging
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <3C0D3F54.8DE05CAB@mvista.com>
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> 
	<3C0D3283.4DA4DD2B@mvista.com> <1007499102.1303.24.camel@phantasy> 
	<3C0D3F54.8DE05CAB@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Dec 2001 16:39:07 -0500
Message-Id: <1007501948.1303.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 16:25, george anzinger wrote:

> NO.  The problem is the first example above.  The spin_unlock will down
> count, but the spin_lockirq did NOT do the paired up count (been there,
> done that).  This is where we need the spin_unlock_no_irq_restore.

Your right, I thought too fast.  Then we need the proper macros ...

	Robert Love

