Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUFVUPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUFVUPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUFVUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:12:40 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34260 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265118AbUFVUJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:09:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.37372.473221.988885@alkaid.it.uu.se>
Date: Tue, 22 Jun 2004 22:09:32 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
In-Reply-To: <1087928274.1881.4.camel@gaston>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
	<1087928274.1881.4.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > Hrm... your code will not work with externally clocked timebases
 > (like the G5) and I'm not sure you get the core freq. right with
 > CPU that can do clock slewing or machines that can switch the
 > core/bus ratio (laptops).

Do you mean the PLL_CFG code that's been in -mm for the last couple
of weeks, or just the recently posted update? The update replaced
in-kernel /proc/cpuinfo parsing (gross) with OF queries taken straight
from the pmac code in arch/ppc/platform/.

I'm ignoring 970/G5 until IBM releases the damn documentation.

 > We should rather define an arch API to return those infos...

No argument there.
