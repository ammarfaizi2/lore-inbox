Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUGFWPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUGFWPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUGFWPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:15:10 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:12705 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264638AbUGFWPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:15:06 -0400
Message-ID: <13e9886104070615087452e595@mail.gmail.com>
Date: Wed, 7 Jul 2004 00:08:12 +0200
From: Carsten Otto <carsten.otto@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: possible arp table corruption [2.4.18]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I switched to read("/proc/net/arp") in my script and basically have no
difference.
Today I found following "nice" bug:

134.130.48.70    0x1         0x2         00:E0:98:AD:01:97     *        eth0
134.130.48.157   0x1         0x2         00:10:4B:4D:01:97     *        eth0
134.130.48.157   0x1         0x2         00:10:4B:45:86:6C     *        eth0

These three entries appeared near the end of the output and had no
lines between them. Notice how the second MAC is composed from the
other two. The first and last entry is correct. If my database and
script etc. work correct, this (wrong) second combination occured at
least five times, but only one of them showed up today.

Where is the bug? What should I do to avoid this?

Thanks,
-- 
Carsten Otto
carsten.otto@gmail.com
http://c-otto.de
