Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTHTLWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTHTLWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:22:52 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26374 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261893AbTHTLWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:22:51 -0400
Subject: [OT] Connection tracking for IPSec
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 13:22:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm starting with IPSec right now. To make it work, I must open up
protocols 50 and 51 to pass across my Linux firewalls, but I want to use
connection tracking much like I do when not using IPSec.

For example,

iptables -A INPUT -m state --state RELATED,ESTABLISHED

When using IPSec, if I open up protocols 50 and 51, all IPSec-protected
traffic passes through the firewall, but it's not checked against the
connection tracking module. How can I configure iptables so an
IPSec-protected packet, after being classified as IP protocol 50 or 51,
loop back one more time to pass through the connection tracking module?

I don't want to set up IPSec to get addititional protection by using AH
and ESP and then let any machine talking IPSec pass entirely through my
firewall ignoring the rest of rules.

Thanks!

