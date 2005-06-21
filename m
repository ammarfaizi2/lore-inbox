Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVFUFyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVFUFyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFUFx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:53:57 -0400
Received: from adsl-69-239-75-171.dsl.pltn13.pacbell.net ([69.239.75.171]:6580
	"EHLO wind.jibenetworks.com") by vger.kernel.org with ESMTP
	id S261875AbVFUFua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 01:50:30 -0400
Subject: one-liner bug in tcp_input.c
From: "Zubin D. Dittia" <zubin@jibenetworks.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Jibe Networks, Inc.
Date: Mon, 20 Jun 2005 22:50:26 -0700
Message-Id: <1119333026.9731.6.camel@zubin.jibenetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was browsing the kernel sources and I think there is a bug near the
top of the tcp_init_metrics() function (in net/ipv4/tcp_input.c).  The
lines are:

if (dst_metric_locked(dst, RTAX_CWND))
        tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);

I think the dst_metric() function should have been called in the first
line above, and not dst_metric_locked() -- this is how it is done in the
code lines following that one.

-Zubin

