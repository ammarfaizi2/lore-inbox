Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUGPKVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUGPKVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 06:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266516AbUGPKVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 06:21:38 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:9344 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S266514AbUGPKVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 06:21:35 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.0/5.0):. Processed in 3.444945 secs)
Date: Fri, 16 Jul 2004 12:21:32 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <505216170.20040716122132@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: tcp_window_scaling degrades performance
In-Reply-To: <m3zn615exj.fsf@averell.firstfloor.org>
References: <2igbK-82L-13@gated-at.bofh.it>
 <m3zn615exj.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AK> It's pretty easy for you to find out. Do a tcpdump -v or ethereal -v
AK> from both the side of a host you download from and from the linux side.
AK> Then compare all packets. If they don't match the firewall is 
AK> doing something bad. Especially check window values and TCP options
AK> in the SYN packets
I will do that for sure, but preliminary investigation shows that
this behaviour does not show with 2.6.7 and earlier, but appears for sure in
2.6.7-bk13 (Haven't tried earlier bk snapshots)

AK> It is very very likely the firewall, window scaling works for a lot
AK> of people.
It is probable, but here: only 2.6.7+ machines behave like this.
I also noticed, that turning tcp_window_scaling off does not always
fix the problem, turning tcp_bic to 0 too helps even more.

Regards,
Maciej


