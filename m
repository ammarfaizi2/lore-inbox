Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTIJBws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 21:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTIJBws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 21:52:48 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:19612 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264469AbTIJBwq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 21:52:46 -0400
Date: Tue, 9 Sep 2003 22:51:48 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac2
Message-Id: <20030909225148.3ce2111c.vmlinuz386@yahoo.com.ar>
In-Reply-To: <200309092334.h89NYxh18536@devserv.devel.redhat.com>
References: <200309092334.h89NYxh18536@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003 19:34:59 -0400 (EDT), Alan Cox wrote:
>(No its not course start time quite yet..)
>
>Various little fixups and tidying bits. Some of these probably want to
>get pushed on to Marcelo eventually - the small bits and the CMPCI update
>certainly.
>
>Linux 2.4.22-ac2
>o	Taint on sii6512 module that someone 		(Arjan van de Ven)
>	"accidentally" marked as GPL but is nonfree
>o	Fix incorrect bool v dep_bool in isdn config	(Paolo Ornati)
>o	Correct ricoh mem0 definition			(Komuro)
>o	Add module device tables to ide pci modules	(Johannes Hölzl)
>o	SATA driver core update				(Jeff Garzik)
>o	Add VIA SATA driver				(Jeff Garzik)
>o	Updated CMPCI driver				(ChenLi Tien)
>o	Fix bridge forwarding with checksumming hw	(Stephen Hemminger)
>o	Fix lots of vblank thinkos	(Soreren Sandmann, Anders Carlsson)
>o	Fix docs typo					(Dafydd Harries)
>o	Small HPT raid updates				(Wilfried Weissmann)
>o	Add Intel ESB2 IDE				(Bill Nottingham)
>o	Fix up LBA48 check for PDC20265			(Petr Vandrovec)
>o	Fix typo in amd76x IDE driver			(Stéphane Loeuillet)
>o	Add VIA 8231 IRQ router entries			(Sebastian Reichelt)
>o	Clean up dead compat warning stuff in isdn	(Gerardo Pozzi)

Thanks, 

This important fix in MASQUERADE code not merged in. From 2.4 tree cset@1.1063.31.1 (laforge)

http://marc.theaimsgroup.com/?l=linux-kernel&m=106208291130074&w=2

--- 1.6/net/ipv4/netfilter/ipt_MASQUERADE.c     Tue Aug 12 02:30:12 2003
+++ 1.7/net/ipv4/netfilter/ipt_MASQUERADE.c     Sat Aug 30 20:45:05 2003
@@ -87,6 +87,7 @@
        key.dst = (*pskb)->nh.iph->daddr;
        key.src = 0; /* Unknown: that's what we're trying to establish */
        key.tos = RT_TOS((*pskb)->nh.iph->tos)|RTO_CONN;
+       key.oif = 0;
 #ifdef CONFIG_IP_ROUTE_FWMARK
        key.fwmark = (*pskb)->nfmark;
 #endif


chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
