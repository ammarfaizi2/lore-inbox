Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVGBC4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVGBC4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVGBC4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:56:40 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:47239 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261701AbVGBCzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 22:55:38 -0400
Date: Fri, 1 Jul 2005 19:55:30 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc1-mm1
Message-Id: <20050701195530.5e4e2b4e.rdunlap@xenotime.net>
In-Reply-To: <200507020443.27889.dominik.karall@gmx.net>
References: <20050701044018.281b1ebd.akpm@osdl.org>
	<200507020443.27889.dominik.karall@gmx.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__1_Jul_2005_19_55_30_-0700_p4Tj=oX2XbuvD6.H"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__1_Jul_2005_19_55_30_-0700_p4Tj=oX2XbuvD6.H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Jul 2005 04:43:23 +0200 Dominik Karall wrote:

| On Friday 01 July 2005 13:40, Andrew Morton wrote:
| > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.
| >6.13-rc1-mm1/
| 
| I get this warning on modules_install:
| WARNING: /lib/modules/2.6.13-rc1-mm1/kernel/net/ieee80211/ieee80211.ko needs 
| unknown symbol is_broadcast_ether_addr


From:	Bernhard Rosenkraenzer <bero@arklinux.org>
To:	akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.13-rc1-mm1 unresolved symbols
Date:	Fri, 1 Jul 2005 18:18:17 +0200
Organization: Ark Linux team
User-Agent: KMail/1.8.1

ipw2200 in 2.6.13-rc1-mm1 makes use of is_broadcast_ether_addr, which was 
removed.

The attached patch restores that function for now.

---


--Multipart=_Fri__1_Jul_2005_19_55_30_-0700_p4Tj=oX2XbuvD6.H
Content-Type: application/octet-stream;
 name="2.6.13-rc1-mm1-restore-is_broadcast_ether_addr.patch"
Content-Disposition: attachment;
 filename="2.6.13-rc1-mm1-restore-is_broadcast_ether_addr.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xMy1yYzEvaW5jbHVkZS9uZXQvaWVlZTgwMjExLmguYXJrCTIwMDUtMDct
MDEgMTc6NDY6MjIuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTMtcmMxL2luY2x1ZGUv
bmV0L2llZWU4MDIxMS5oCTIwMDUtMDctMDEgMTc6NDc6MjYuMDAwMDAwMDAwICswMjAwCkBAIC02
MjcsNiArNjI3LDExIEBACiAjZGVmaW5lIE1BQ19GTVQgIiUwMng6JTAyeDolMDJ4OiUwMng6JTAy
eDolMDJ4IgogI2RlZmluZSBNQUNfQVJHKHgpICgodTgqKSh4KSlbMF0sKCh1OCopKHgpKVsxXSwo
KHU4KikoeCkpWzJdLCgodTgqKSh4KSlbM10sKCh1OCopKHgpKVs0XSwoKHU4KikoeCkpWzVdCiAK
K2V4dGVybiBpbmxpbmUgaW50IGlzX2Jyb2FkY2FzdF9ldGhlcl9hZGRyKGNvbnN0IHU4ICphZGRy
KQoreworCXJldHVybiAoKGFkZHJbMF0gPT0gMHhmZikgJiYgKGFkZHJbMV0gPT0gMHhmZikgJiYg
KGFkZHJbMl0gPT0gMHhmZikgJiYKKwkJKGFkZHJbM10gPT0gMHhmZikgJiYgKGFkZHJbNF0gPT0g
MHhmZikgJiYgKGFkZHJbNV0gPT0gMHhmZikpOworfQogCiAjZGVmaW5lIENGR19JRUVFODAyMTFf
UkVTRVJWRV9GQ1MgKDE8PDApCiAjZGVmaW5lIENGR19JRUVFODAyMTFfQ09NUFVURV9GQ1MgKDE8
PDEpCgo=

--Multipart=_Fri__1_Jul_2005_19_55_30_-0700_p4Tj=oX2XbuvD6.H--
