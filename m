Return-Path: <linux-kernel-owner+w=401wt.eu-S932096AbXAOIbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXAOIbZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbXAOIbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:31:25 -0500
Received: from stinky.trash.net ([213.144.137.162]:52894 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbXAOIbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:31:24 -0500
Message-ID: <45AB3BDA.6050300@trash.net>
Date: Mon, 15 Jan 2007 09:31:22 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH 2.6.20-rc5] netfilter: xt_state compile failure
References: <17835.13603.658813.332230@alkaid.it.uu.se>
In-Reply-To: <17835.13603.658813.332230@alkaid.it.uu.se>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> include/net/netfilter/nf_conntrack_compat.h: In function 'nf_ct_l3proto_try_module_get':
> include/net/netfilter/nf_conntrack_compat.h:70: error: 'PF_INET' undeclared (first use in this function)
> include/net/netfilter/nf_conntrack_compat.h:70: error: (Each undeclared identifier is reported only once
> include/net/netfilter/nf_conntrack_compat.h:70: error: for each function it appears in.)
> include/net/netfilter/nf_conntrack_compat.h:71: warning: control reaches end of non-void function
> make[2]: *** [net/netfilter/xt_state.o] Error 1
> make[1]: *** [net/netfilter] Error 2
> make: *** [net] Error 2
> 
> A simple fix is to have nf_conntrack_compat.h #include <linux/socket.h>.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied, thanks Mikael.
