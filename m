Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUHCBC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUHCBC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 21:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHCBC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 21:02:26 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:65174 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264767AbUHCBCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 21:02:15 -0400
Date: Tue, 3 Aug 2004 02:00:55 +0100
From: Dave Jones <davej@redhat.com>
To: ralph@convergence.de, marcus@convergence.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: boolean typo in DVB
Message-ID: <20040803010055.GB12571@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ralph@convergence.de,
	marcus@convergence.de, Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like what was intended here..

		Dave


Signed-off-by: Dave Jones <davej@redhat.com>

--- 1/drivers/media/dvb/dvb-core/dvb_demux.c~	2004-08-03 01:57:45.605369592 +0100
+++ 2/drivers/media/dvb/dvb-core/dvb_demux.c	2004-08-03 01:57:58.979336440 +0100
@@ -179,7 +179,7 @@
 		neq |= f->maskandnotmode[i] & xor;
 	}
 
-	if (f->doneq & !neq)
+	if (f->doneq && !neq)
 		return 0;
 
 	return feed->cb.sec (feed->feed.sec.secbuf, feed->feed.sec.seclen, 
