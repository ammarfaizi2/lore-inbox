Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVAaFoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVAaFoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVAaFoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:44:25 -0500
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:39822 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S261928AbVAaFoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:44:11 -0500
Date: Mon, 31 Jan 2005 14:42:52 +0900 (JST)
Message-Id: <200501310542.j0V5grsI029994@toshiba.co.jp>
To: yoshfuji@linux-ipv6.org
Cc: kaber@trash.net, kozakai@linux-ipv6.org, herbert@gondor.apana.org.au,
       davem@davemloft.net, rmk+lkml@arm.linux.org.uk,
       Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
       alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
From: Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>
In-Reply-To: <20050131.141636.20664459.yoshfuji@linux-ipv6.org>
References: <20050131.134559.125426676.yoshfuji@linux-ipv6.org>
	<41FDBB78.2050403@trash.net>
	<20050131.141636.20664459.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
Date: Mon, 31 Jan 2005 14:16:36 +0900 (JST)

> In article <41FDBB78.2050403@trash.net> (at Mon, 31 Jan 2005 06:00:40 +0100), Patrick McHardy <kaber@trash.net> says:
> 
> |We don't need this for IPv6 yet. Once we get nf_conntrack in we
> |might need this, but its IPv6 fragment handling is different from
> |ip_conntrack, I need to check first.
> 
> Ok. It would be better to have some comment but anyway...
> kozakai-san?

IMO, fix for nf_conntrack isn't needed yet. Because someone may change
IPv6 fragment handling in nf_conntrack.

Anyway, current nf_conntrack passes the original (not de-fragmented) skb to
IPv6 stack. nf_conntrack doesn't touch its dst.

Regards,
----------------------------------------
Yasuyuki KOZAKAI

Communication Platform Laboratory,
Corporate Research & Development Center,
Toshiba Corporation

yasuyuki.kozakai@toshiba.co.jp
----------------------------------------
