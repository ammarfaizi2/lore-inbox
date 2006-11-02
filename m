Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752712AbWKBHoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbWKBHoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbWKBHoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:44:24 -0500
Received: from main.gmane.org ([80.91.229.2]:38635 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752712AbWKBHoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:44:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for paravirtualizing critical operations
Date: Thu, 2 Nov 2006 07:44:03 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnekj8qv.2in.olecom@flower.upol.cz>
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de> <1162178936.9802.34.camel@localhost.localdomain> <20061030231132.GA98768@muc.de> <1162376827.23462.5.camel@localhost.localdomain> <20061101231313.4c91a9a9.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: virtualization@lists.osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-02, Andrew Morton wrote:
> This patch breaks `make headers_check' in mysterious ways:
>
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_tcp.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_sctp.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_protocol.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_types.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper.h
> make[2]: *** [/usr/src/devel/usr/include/asm/.check.setup.h] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [asm-i386] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [headers_check] Error 2

It seems like missing
"header-y += paravirt.h" in the "include/asm-i386/Kbuild".
____

