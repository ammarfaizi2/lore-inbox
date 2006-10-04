Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWJDSCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWJDSCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWJDSCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:02:13 -0400
Received: from ackle.nomi.cz ([81.31.33.35]:16011 "EHLO ackle.nomi.cz")
	by vger.kernel.org with ESMTP id S1161901AbWJDSCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:02:04 -0400
Date: Wed, 4 Oct 2006 20:02:01 +0200
From: onovy@nomi.cz
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack_core - possible memory leak in 2.4
Message-ID: <20061004180201.GA18386@nomi.cz>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have there MontaVista based router, with 2.4.17_mvl21-malta-mips_fp_le
kernel. I think, there is memory leak in ip_conntrack code. There are
eta 500 conntrack connection all the time. But after some day i get
"ip_conntrack: table full" in kmsg.
/proc/sys/net/ipv4/netfilter/ip_conntrack_max have 3072 value.
grep ip_conntrack /proc/slabinfo
ip_conntrack        3006   3250    384  319  325    1
^^ there are 3006 allocated conntracks
cat /proc/net/ip_conntrack | wc -l
30
^^ in table are only 30 lines.

Acording to this:
http://lists.netfilter.org/pipermail/netfilter-devel/2004-May/015628.html
i don't think, this is fixed in 2.4 tree, but i can't test it with newer
version.

Thanks
-- 
S pozdravem/Best regards
 Ondrej Novy
 
Email: onovy@nomi.cz
Jabber: onovy@njs.netlab.cz
ICQ: 115-674-713
MSN: onovy@hotmail.com
Yahoo ID: novy_ondrej
Tel/Cell: +420 777 963 207
