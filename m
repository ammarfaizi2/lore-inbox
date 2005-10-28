Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbVJ1V0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbVJ1V0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbVJ1V0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:26:13 -0400
Received: from mx1.netapp.com ([216.240.18.38]:28203 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1751816AbVJ1V0M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:26:12 -0400
X-IronPort-AV: i="3.97,263,1125903600"; 
   d="scan'208"; a="264933380:sNHT17422636"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Link error in ./net/sunrcp/
Date: Fri, 28 Oct 2005 14:26:11 -0700
Message-ID: <044B81DE141D7443BCE91E8F44B3C1E288E5B7@exsvl02.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Link error in ./net/sunrcp/
Thread-Index: AcXcBW5uHTyRNiGrQwqSsYg17sjYNgAAIbuw
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: "Myklebust, Trond" <Trond.Myklebust@netapp.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Oct 2005 21:26:11.0290 (UTC) FILETIME=[37BBDBA0:01C5DC06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi!
> 
> I get this link error:
> 
> net/built-in.o: In function 
> `xs_bindresvport':xprtsock.c:(.text+0x46970): undefined 
> reference to `xprt_min_resvport'
> :xprtsock.c:(.text+0x46978): undefined reference to 
> `xprt_max_resvport'
> net/built-in.o: In function `xs_setup_udp': undefined 
> reference to `xprt_udp_slot_table_entries'
> net/built-in.o: In function `xs_setup_tcp': undefined 
> reference to `xprt_tcp_slot_table_entries'
> make: *** [.tmp_vmlinux1] Error 1
> 
> in case of CONFIG_SYSCTL not being enabled. This is on the VAX port,
> but I guess it'll show up on any target...

i thought that you couldn't actually get a .config that would build
the sunrpc stuff if CONFIG_SYSCTL was disabled.  thus the macro logic
in net/sunrpc doesn't check for it.

was i wrong about that?
