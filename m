Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293366AbSBYKnu>; Mon, 25 Feb 2002 05:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293368AbSBYKnb>; Mon, 25 Feb 2002 05:43:31 -0500
Received: from zamok.crans.org ([138.231.136.6]:28650 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S293366AbSBYKnT>;
	Mon, 25 Feb 2002 05:43:19 -0500
To: linux-kernel@vger.kernel.org
Subject: static arp table doesn't size up ?
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
Organization: Kabale Inc
Date: Mon, 25 Feb 2002 11:43:15 +0100
Message-ID: <m34rk5suyk.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

We have a 2.4.16 generic kernel and we run into troubles with arp. We
have an ethernet segment of 600+ machines. On one of these machines, I
have set up a static arp table by entering every mac-ip couple.

For several days, I have left the ARP learning (ifconfig eth0 arp) and
there was no problem. Every 5 minutes, I have checked if there was
learned address in the arp cache : there was none, so it didn't learn
any new address.

Today, I have switch to a real static arp table (with ifconfig eth0
-arp). Randomly, some machines were then unable to ping the
host.

After a "ifconfig eth0 arp ; ifconfig eth0 -arp", this some other
machine which were unable to ping the host where the first machines
are able to do it again. arp table is correct but randomly, some
machines are unable to get their echo reply, even if its entry is in
the arp table.

Are there known issues about large arp tables ?
