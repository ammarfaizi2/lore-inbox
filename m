Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268123AbTGLSHv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbTGLSHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:07:51 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:15270 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S268123AbTGLSHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:07:51 -0400
To: <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: Logical interfaces (VLANs etc) flow control
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Jul 2003 18:03:35 +0200
Message-ID: <m3isq7ag14.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

probably a simple question: do we currently do any flow control for
logical subinterfaces (specifically 802.1q VLANs) similar to
netif_{stop,wake}_queue on the main (physical) device?

I notice "txqueuelen:0" on VLAN devices and vlan_dev_hard_start_xmit()
seems to not do any flow control, but I wonder if there is something
else?

The problem is I'm doing the same with Frame Relay, should I add a TX
queue to FR PVC devices and possibly stop/wake PVC device queue in sync
with physical device queue?

Possibly a pointer to faq or something?
-- 
Krzysztof Halasa
Network Administrator
