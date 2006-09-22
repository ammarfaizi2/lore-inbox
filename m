Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWIVH7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWIVH7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIVH7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:59:05 -0400
Received: from mx2.go2.pl ([193.17.41.42]:63693 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750928AbWIVH7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:59:03 -0400
Date: Fri, 22 Sep 2006 10:03:10 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 7179] New: Compilation of .tmp_linux1 fails due to missing declaration in net/netfilter/xt_physdev.c
Message-ID: <20060922080310.GA1012@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921153701.2c49e331.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-2006 00:37, Andrew Morton wrote:
> Methinks CONFIG_NETFILTER_XT_TARGET_CLASSIFY should depend upon
> CONFIG_BRIDGE_NETFILTER.  Because brnf_deferred_hooks is defined in
> net/bridge/br_netfilter.c and is referred to in net/netfilter/xt_physdev.c.
> 
> Or something else ;)

>From net/netfilter/Kconfig:

config NETFILTER_XT_MATCH_PHYSDEV
        tristate '"physdev" match support'
        depends on NETFILTER_XTABLES && BRIDGE_NETFILTER

so "properly" generated .config should be enough.

Jarek P.

PS: I've just checked and it compiles OK. 
