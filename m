Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTKJL3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTKJL3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:29:35 -0500
Received: from web25203.mail.ukl.yahoo.com ([217.12.10.63]:30374 "HELO
	web25203.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263173AbTKJL3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:29:34 -0500
Message-ID: <20031110112933.52101.qmail@web25203.mail.ukl.yahoo.com>
Date: Mon, 10 Nov 2003 12:29:33 +0100 (CET)
From: =?iso-8859-1?q?francois=20donzet?= <fdonzet@yahoo.fr>
Subject: checksum offloading
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i have a little question : 

When tcp checksum offloading is enabled, the chip
computes a sum on all words of the packet contents and
stores the result in skb->csum, setting skb->ip_summed
to CHECKSUM_HW. (see for example, e100_main.c)

Then, when packet reaches tcp layer, via
tcp_checksum_init(), tcp checksum is verified (using
together skb->csum and the pseudo header checksum).

How does TCP deal with skb->csum, as it doesn't cover
only the tcpheader+data (but ipheader+tcpheader+data)

Thanks.



___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
