Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWH0DHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWH0DHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 23:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWH0DHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 23:07:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24552
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751148AbWH0DHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 23:07:20 -0400
Date: Sat, 26 Aug 2006 20:07:16 -0700 (PDT)
Message-Id: <20060826.200716.85410384.davem@davemloft.net>
To: gerrit@erg.abdn.ac.uk
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2.6.17] net/ipv6/udp.c: remove duplicate udp_get_port
 code
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608171325.47349@strip-the-willow>
References: <200608171325.47349@strip-the-willow>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: gerrit@erg.abdn.ac.uk
Date: Thu, 17 Aug 2006 13:25:46 +0100

> [NET]: UDPv4 and UDPv6 use an almost identical version of the get_port function,
> which is unnecessary since the (long) code differs in only one if-statement.
> 
> This patch creates one common function which is called by udp_v4_get_port() and
> udp_v6_get_port(). As a result,
>   * duplicated code is removed
>   * udp_port_rover and local port lookup can now be removed from udp.h
>   * further savings follow since the same function will be used by UDP-Litev4 
>     and UDP-Litev6
> 
> In contrast to the patch sent in response to Yoshifujis comments (fixed by this
> variant), the code below also removes the EXPORT_SYMBOL(udp_port_rover), since
> udp_port_rover can now remain local to net/ipv4/udp.c.
> 
> Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>

Applied, and I marked udp_port_rover "static" for
good measure.

Thanks.

