Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUGIRFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUGIRFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUGIRFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:05:12 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:39318 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S265098AbUGIRFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:05:06 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.0/5.0):. Processed in 3.333739 secs)
Date: Fri, 9 Jul 2004 19:05:02 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <76430384.20040709190502@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: TCP BIC problems - make it off by default ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.6.7 I have had problems with my server downloading and people
uploading to the server. The throughput was never higher than 4kB/s

I have found that when /proc/sys/net/ipv4/tcp_bic is 1 (which is the
default) I am experiencing this behaviour. When I switch it off.
It's back to normal again.

I have read that BIC is for super high speed, long distance links,
which are not the most common links in the wild, so maybe it would
be better to turn tcp_bic to 0 by default so as not to ruin the links
of innocent upgraders.

I am no guru, but BIC maybe failing at my end because, my LAN is 100Mb
ethernet, the Internet link is an old 10Mb fddi half duplex, and the
links on the MAN ring are (i think) 155Mb ATM links.

Maybe that's a very bad combination, or some devices on my network,
especially the firewall (checkpoint) may react weird.

Anyway, because of that tcp_bic may cause problems and because it is
use will not be common anyway, maybe it would be better to mark it off
by default.

Regards,
Maciej


