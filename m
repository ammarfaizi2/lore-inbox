Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUCPXGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCPXGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:06:17 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:44224 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S261791AbUCPXGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:06:12 -0500
Subject: netfilter.diff resend
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Reply-To: sergiomb@netcabo.pt
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-mshrTqgvmhr0P755n5dg"
Message-Id: <1079478370.2496.12.camel@darkstar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 16 Mar 2004 23:06:10 +0000
X-OriginalArrivalTime: 16 Mar 2004 23:06:12.0115 (UTC) FILETIME=[465ED630:01C40BAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mshrTqgvmhr0P755n5dg
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi
Marcelo can you apply this patch? for work with IP Masquerade.

Reference:
http://lists.netfilter.org/pipermail/netfilter-devel/2002-November/009928.h=
tml

In begin, I apply this patch on redhat 7.3 box and thought this is a
specific problem of RedHat compiler, but I see exactly the same=20
dependency dropped on a slackware-9.1 with kernel 2.4.25 and gcc3.3, do
me a favor and apply this mini patch.
--=20
S=E9rgio M. B.

--=-mshrTqgvmhr0P755n5dg
Content-Disposition: attachment; filename=netfilter.diff
Content-Type: text/x-patch; name=netfilter.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- 2.4.20/include/linux/netfilter_ipv4/ip_conntrack.h.orig	Sat May 31 23:22:01 2003
+++ 2.4.20+/include/linux/netfilter_ipv4/ip_conntrack.h	Sun Jun  1 00:11:03 2003
@@ -156,7 +156,8 @@
 	union ip_conntrack_expect_help help;
 };
 
-#include <linux/netfilter_ipv4/ip_conntrack_helper.h>
+struct ip_conntrack_helper;
+
 struct ip_conntrack
 {
 	/* Usage count in here is 1 for hash table/destruct timer, 1 per skb,

--=-mshrTqgvmhr0P755n5dg--

