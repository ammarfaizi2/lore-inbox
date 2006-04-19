Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWDSTYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDSTYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDSTYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:24:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751187AbWDSTYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:24:08 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Adrian Bunk <bunk@stusta.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604191415590.28421@chaos.analogic.com>
References: <20060418220715.GO11582@stusta.de>
	 <20060419051355.GI4825@rhun.haifa.ibm.com>
	 <20060419180724.GD25047@stusta.de>
	 <Pine.LNX.4.61.0604191415590.28421@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 21:23:45 +0200
Message-Id: <1145474625.3085.101.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 14:21 -0400, linux-os (Dick Johnson) wrote:
> On Wed, 19 Apr 2006, Adrian Bunk wrote:
> 
> > On Wed, Apr 19, 2006 at 08:13:55AM +0300, Muli Ben-Yehuda wrote:
> >> On Wed, Apr 19, 2006 at 12:07:15AM +0200, Adrian Bunk wrote:
> >>> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated
> >>> on i386.
> >>
> >> You should probably update Documentation/ while you're at it.
> >
> > Which file under Documentation/ are you referring to?
> >
> >> Also, IIRC Xen uses virt_to_phys to return guest physical addresses
> >> and virt_to_bus to return machine physical addresses, so the
> >> difference is useful at least in some scenarios.
> >
> > Solving this should be easy.
> >
> > And this still doesn't make it right for architecture independent
> > drivers to use virt_to_bus/bus_to_virt.
> 
> Then what would you use to return the proper bus address to put
> into a DMA scatter list and, conversely, how would you convert
> those bus addresses into something a virtual mode CPU could
> access?  These macros used to be the link that made such driver
> coding architecture independent. You cannot just claim that
> one can't make such conversions anymore. The CPU uses virtual
> addresses and the DMA uses physical (bus) addresses. Do we
> throw away DMA altogether?

since a long time the kernel has proper dma mapping API's for this, in
2.4 it's pci specific in 2.6 it's generic and bus agnostic.


