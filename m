Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUGOPJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUGOPJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUGOPJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:09:42 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:15366 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S266213AbUGOPJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:09:40 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.0/5.0):. Processed in 3.413665 secs)
Date: Thu, 15 Jul 2004 17:09:37 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1956423367.20040715170937@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: tcp_window_scaling degrades performance
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have been experiencied weird problems with network throughput
lately and I after experimenting with /proc/sys/net/ipv4 knobs
I found that when I have tcp_window_scaling 0 I can
get throughput from a distant server of about 600kB/s (well, 200kB/s
is fast enough)

   # links ftp://ftp.task.gda.pl/ls-lR

When I turn tcp_window_scaling to 1 the transfer starts with 600kB,
then drops nicely to 20kB/s then starts growing again and reaches
about 400kB/s

Anyway It works, but there are some hosts, with which I can't talk to
faster than 800B/s !

This is a Debian SID with vanilla-2.6.7-bk20, but I am having these
problems for a few weeks now.

It might be a TCP kernel issue, but I know that between me and the
other hosts is a checkpoint fw-1 fp3, it may be the cause of problems,
because, well, checkpoint is crazy.

Anyway, I can provide tcpdump, and tcptrace analysis of it and the
state of sysctls if anyone would be willing to help me figure out
what's going on.

Regards,
Maciej


