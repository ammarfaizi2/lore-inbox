Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbTH3TmE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 15:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbTH3TmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 15:42:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16852 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262159AbTH3TmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 15:42:01 -0400
Date: Sat, 30 Aug 2003 16:37:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: system_lists@nullzone.org
Cc: "David S. Miller" <davem@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre2
Message-ID: <Pine.LNX.4.55L.0308301636520.31751@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess that will come through davem?

----
Hello Marcelo,

   You have forgot the "Patrick McHardy [kaber@trash.net]" patch to get the
MASQUERADE/FORWARD working again ( so important! :-) ).

Please, add it when you get a minute.

===== net/ipv4/netfilter/ipt_MASQUERADE.c 1.6 vs edited =====
--- 1.6/net/ipv4/netfilter/ipt_MASQUERADE.c     Tue Aug 12 11:30:12 2003
+++ edited/net/ipv4/netfilter/ipt_MASQUERADE.c  Thu Aug 28 16:54:15 2003
@@ -90,6 +90,7 @@
 #ifdef CONFIG_IP_ROUTE_FWMARK
        key.fwmark = (*pskb)->nfmark;
 #endif
+       key.oif = 0;
        if (ip_route_output_key(&rt, &key) != 0) {
                 /* Funky routing can do this. */
                 if (net_ratelimit())


