Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUI0AZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUI0AZu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 20:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUI0AZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 20:25:50 -0400
Received: from aun.it.uu.se ([130.238.12.36]:44700 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265195AbUI0AZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 20:25:49 -0400
Date: Mon, 27 Sep 2004 02:25:36 +0200 (MEST)
Message-Id: <200409270025.i8R0PaxN012405@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: Re: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 09:49:45 +1000, Benjamin Herrenschmidt wrote:
> Be careful that some G4's have a bug which can cause a
> perf monitor interrupt to crash your kernel :( Basically, the
> problem is if any of TAU or PerfMon interrupt happens at the
> same time as a DEC interrupt, some revs of the CPU can get
> confused and lose the previous exception state.

Oh I'm very much aware of that erratum. That's why I never
even tried implementing this while I only had a 750/G3.
The error appears to affect all classic 750s, all 7400s,
and early 7410s. Late 7410s and all 744x/745x are Ok.
I don't know if IBM's recent 750s (GX/FX) have the error,
but their 750CXs do.

/Mikael
