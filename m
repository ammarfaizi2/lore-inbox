Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUFHNv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUFHNv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 09:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFHNvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 09:51:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:13208 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265206AbUFHNvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 09:51:54 -0400
Date: Tue, 8 Jun 2004 15:51:46 +0200 (MEST)
Message-Id: <200406081351.i58Dpkua027854@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] 2.6.7-rc2-mm2 perfctr #if/#ifdef cleanup
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2004 16:23:31 -0400, Valdis.Kletnieks@vt.edu wrote:
> Cleaning up some #if/#ifdef confusion in the perfctr patch...

To clarify: the confusion is not that those two symbols
(PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED and PERFCTR_INTERRUPT_SUPPORT)
are tested with #if in some places and #ifdef in others;
instead it is that the symbols are either 1 or undefined,
but always tested with #if. This, while valid C, may seem
slightly strange.

Thanks Valdis for pointing this out. I'll clean this up.

Andrew: please apply Valdis' cleanup patch.
(I can send a new one if you didn't save it.)

/Mikael
