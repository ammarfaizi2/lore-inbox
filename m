Return-Path: <linux-kernel-owner+w=401wt.eu-S932268AbXAOMNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbXAOMNU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbXAOMNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:13:20 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51872 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbXAOMNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:13:19 -0500
X-Originating-Ip: 74.109.98.130
Date: Mon, 15 Jan 2007 06:43:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: kkeil@suse.de
Subject: any value to fixing apparent bugs in old ISDN4Linux?
Message-ID: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


$ grep -r DE_AOC .
./.config:CONFIG_DE_AOC=y
./drivers/isdn/hisax/l3dss1.c:#ifdef HISAX_DE_AOC
./drivers/isdn/hisax/l3dss1.c:#else  /* not HISAX_DE_AOC */
./drivers/isdn/hisax/l3dss1.c:#endif /* not HISAX_DE_AOC */
./drivers/isdn/hisax/Kconfig:config DE_AOC

  it seems like there's a name mismatch between the config variable
and the one that's being tested, no?

  OTOH, since that code *is* in the allegedly obsolete old ISDN4Linux
code, perhaps that entire part of the tree can just be junked.  but if
it's sticking around, it should probably be fixed.

  unless i'm misreading something up there.

rday
