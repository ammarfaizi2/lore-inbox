Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUFVUhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUFVUhT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUFVU2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:28:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:34986 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265906AbUFVU1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:27:41 -0400
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16600.37372.473221.988885@alkaid.it.uu.se>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
	 <1087928274.1881.4.camel@gaston>
	 <16600.37372.473221.988885@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1087935661.1855.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 15:21:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 15:09, Mikael Pettersson wrote:
> Benjamin Herrenschmidt writes:
>  > Hrm... your code will not work with externally clocked timebases
>  > (like the G5) and I'm not sure you get the core freq. right with
>  > CPU that can do clock slewing or machines that can switch the
>  > core/bus ratio (laptops).
> 
> Do you mean the PLL_CFG code that's been in -mm for the last couple
> of weeks, or just the recently posted update? The update replaced
> in-kernel /proc/cpuinfo parsing (gross) with OF queries taken straight
> from the pmac code in arch/ppc/platform/.
> 
> I'm ignoring 970/G5 until IBM releases the damn documentation.

Well, the G5 can have it's own tb but can also be externally clocked and
that's how Apple does. I'm not sure about all G4 models.

>  > We should rather define an arch API to return those infos...
> 
> No argument there.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

