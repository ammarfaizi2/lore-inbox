Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUI0Aib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUI0Aib (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 20:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUI0Aib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 20:38:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:23689 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265207AbUI0Ai2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 20:38:28 -0400
Subject: Re: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <200409270025.i8R0PaxN012405@harpo.it.uu.se>
References: <200409270025.i8R0PaxN012405@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1096245402.18029.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 10:36:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 10:25, Mikael Pettersson wrote:
> On Mon, 27 Sep 2004 09:49:45 +1000, Benjamin Herrenschmidt wrote:
> > Be careful that some G4's have a bug which can cause a
> > perf monitor interrupt to crash your kernel :( Basically, the
> > problem is if any of TAU or PerfMon interrupt happens at the
> > same time as a DEC interrupt, some revs of the CPU can get
> > confused and lose the previous exception state.
> 
> Oh I'm very much aware of that erratum. That's why I never
> even tried implementing this while I only had a 750/G3.
> The error appears to affect all classic 750s, all 7400s,
> and early 7410s. Late 7410s and all 744x/745x are Ok.
> I don't know if IBM's recent 750s (GX/FX) have the error,
> but their 750CXs do.

Oh, interesting... I wasn't sure about the G3s, though iirc,
we discovered the error in the first place with MOL on an old G3
indeed...

Ben.




