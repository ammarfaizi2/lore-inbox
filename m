Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTEIPHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTEIPHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 11:07:13 -0400
Received: from holomorphy.com ([66.224.33.161]:45728 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263281AbTEIPHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 11:07:12 -0400
Date: Fri, 9 May 2003 08:19:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030509151929.GA19053@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Willy Tarreau <willy@w.ods.org>,
	Stephan von Krawczynski <skraw@ithnet.com>, gibbs@scsiguy.com,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030509132757.GA16649@alpha.home.local> <20030509154637.5cf14c8d.skraw@ithnet.com> <20030509145621.GA17581@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509145621.GA17581@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 04:56:21PM +0200, Willy Tarreau wrote:
> I don't see how ~0xFFFFFFFF can be non-null on 32 bits archs, because addr is
> a bus_addr_t which is in turn dma_addr_t which itself is u32. So unless I don't
> find the trick this would mean that this code should never be executed. Perhaps
> ~0xFFFFFFFFULL would be more appropriate, or even >0xFFFFFFFF, since this can be
> detected with u32 using the carry left by the addition.

include/asm-i386/types.h line 55

#ifdef CONFIG_HIGHMEM
typedef u64 dma_addr_t;
#else
typedef u32 dma_addr_t;
#endif


-- wli
