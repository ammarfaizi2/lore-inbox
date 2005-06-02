Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVFBURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVFBURW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFBUPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:15:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52952
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261319AbVFBUN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:13:26 -0400
Date: Thu, 02 Jun 2005 13:13:14 -0700 (PDT)
Message-Id: <20050602.131314.21926883.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/ipv4/: possible cleanups
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050530205651.GY10441@stusta.de>
References: <20050530205651.GY10441@stusta.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] net/ipv4/: possible cleanups
Date: Mon, 30 May 2005 22:56:51 +0200

> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global function:
>   - xfrm4_state.c: xfrm4_state_fini
> - remove the following unneeded EXPORT_SYMBOL's:
>   - ip_output.c: ip_finish_output
>   - ip_output.c: sysctl_ip_default_ttl
>   - fib_frontend.c: ip_dev_find
>   - inetpeer.c: inet_peer_idlock
>   - ip_options.c: ip_options_compile
>   - ip_options.c: ip_options_undo
>   - tcp_ipv4.c: sysctl_max_syn_backlog
> 
> Please review which of these changes are correct and which might 
> conflict with pending patches.

Please keep all of the ECN implementation in the
tcp_ecn.h header file, even if the routine is only
called in one C file.

And therefore, please do not remove the tcp_enter_quickack_mode()
extern declaration from tcp.h

Thanks.
