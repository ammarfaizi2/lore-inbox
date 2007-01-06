Return-Path: <linux-kernel-owner+w=401wt.eu-S1751339AbXAFKvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbXAFKvX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 05:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXAFKvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 05:51:23 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50926 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbXAFKvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 05:51:22 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 6 Jan 2007 05:46:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: "do_gettimeofday" vs "get_realtime_clock_ts" vs "__get_realtime_clock_ts"
Message-ID: <Pine.LNX.4.64.0701060542260.11402@localhost.localdomain>
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


  i notice, in kernel/timer.c, the kernel-doc comment for
do_gettimeofday():

  NOTE: Users should be converted to using get_realtime_clock_ts()

does this mean that do_gettimeofday() should be officially deprecated?
that *seems* to be what that note is suggesting.

  in any event, there is no "get_realtime_clock_ts" routine -- it's
actually called "__get_realtime_clock_ts".  so *something* should be
fixed here, no?

rday
