Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUH3LBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUH3LBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 07:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUH3LBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 07:01:12 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:19361 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S267661AbUH3LBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 07:01:08 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org,netdev@oss.sgi.com
X-Qmail-Scanner: 1.23 (Clear:RC:0(150.254.37.14):. Processed in 0.031651 secs)
Date: Mon, 30 Aug 2004 13:00:37 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.12.3) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <512805293.20040830130037@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: TCP Window Scaling problem with buggy routers FIX works
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am just letting you guys know that the fix for
tcp window scaling problem with buggy routers works.

There were people (including me) reporting that tcp traffic
through some buggy (eg. cisco) routers in linux-2.6.8 slows
down to a crawl.

A workaround was to zero tcp_window_scaling sysctl knob.

With this patch:
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-shemminger@osdl.org|ChangeSet|20040826205608|22084.txt

sitting in 2.6.9-rc1 BK repository the linux box can have
fast transfers again.

Note that they are not that fast as with tcp_window_scaling disabled.
But they are certainly fast and will not cause problems like
ssh sessions hangning, etc.

Thanks for the workaround for buggy routers netdev!

Cheers,
Maciej


