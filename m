Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTJUPhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTJUPhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:37:53 -0400
Received: from [65.172.181.6] ([65.172.181.6]:44469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263136AbTJUPhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:37:51 -0400
Date: Tue, 21 Oct 2003 08:36:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Suh Jin" <suh_jin@bah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8 modules_install unresolved symbol errors
Message-Id: <20031021083614.7b123c97.rddunlap@osdl.org>
In-Reply-To: <3F954881.1030508@bah.com>
References: <3F954881.1030508@bah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 10:53:54 -0400 "Suh Jin" <suh_jin@bah.com> wrote:

| Could someone help me why I am getting unresolved symbols when I run 
| "make modules_install". How do I fix those? I am using RedHat9.0 and I 
| have same problems using gcc2.95.3 and gcc3.2.2. BTW, it doesn't matter 
| mm1 patch or vanilla kernel.
| 
| depmod: *** Unresolved symbols in 
| /lib/modules/2.6.0-mm1/kernel/net/ipv4/ipvs/ip_vs_wlc.ko
| depmod:         register_ip_vs_scheduler
| depmod:         unregister_ip_vs_scheduler
| depmod: *** Unresolved symbols in 
| /lib/modules/2.6.0-mm1/kernel/net/ipv4/ipvs/ip_vs_wrr.ko
| depmod:         register_ip_vs_scheduler
| depmod:         unregister_ip_vs_scheduler
| depmod: *** Unresolved symbols in 
| /lib/modules/2.6.0-mm1/kernel/net/ipv4/netfilter/arptable_filter.ko
| depmod:         arpt_register_table
| depmod:         arpt_do_table
| depmod:         arpt_unregister_table
| ........ bunch of more unresolved symbols

Are you using module-init-tools?
  (from http://www.kernel.org/pub/linux/kernel/people/rusty/modules/)

If so, they aren't in $PATH when you ran depmod.
Current (new) depmod doesn't have this message.

For 2.6.x changes, you probably want/need to read this:
http://www.codemonkey.org.uk/post-halloween-2.5.txt

--
~Randy
