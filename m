Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWGQQcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWGQQcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWGQQcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:33466 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750939AbWGQQcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:01 -0400
Date: Mon, 17 Jul 2006 09:27:14 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/45] v4l/dvb: Backport fix to artec USB DVB devices
Message-ID: <20060717162714.GR4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-backport-fix-to-artec-usb-dvb-devices.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

Backport fix to artec USB DVB devices

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/frontends/dvb-pll.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.17.3.orig/drivers/media/dvb/frontends/dvb-pll.c
+++ linux-2.6.17.3/drivers/media/dvb/frontends/dvb-pll.c
@@ -194,11 +194,11 @@ struct dvb_pll_desc dvb_pll_tda665x = {
 		{  253834000, 36249333, 166667, 0xca, 0x62 /* 011 0 0 0  10 */ },
 		{  383834000, 36249333, 166667, 0xca, 0xa2 /* 101 0 0 0  10 */ },
 		{  443834000, 36249333, 166667, 0xca, 0xc2 /* 110 0 0 0  10 */ },
-		{  444000000, 36249333, 166667, 0xca, 0xc3 /* 110 0 0 0  11 */ },
-		{  583834000, 36249333, 166667, 0xca, 0x63 /* 011 0 0 0  11 */ },
-		{  793834000, 36249333, 166667, 0xca, 0xa3 /* 101 0 0 0  11 */ },
-		{  444834000, 36249333, 166667, 0xca, 0xc3 /* 110 0 0 0  11 */ },
-		{  861000000, 36249333, 166667, 0xca, 0xe3 /* 111 0 0 0  11 */ },
+		{  444000000, 36249333, 166667, 0xca, 0xc4 /* 110 0 0 1  00 */ },
+		{  583834000, 36249333, 166667, 0xca, 0x64 /* 011 0 0 1  00 */ },
+		{  793834000, 36249333, 166667, 0xca, 0xa4 /* 101 0 0 1  00 */ },
+		{  444834000, 36249333, 166667, 0xca, 0xc4 /* 110 0 0 1  00 */ },
+		{  861000000, 36249333, 166667, 0xca, 0xe4 /* 111 0 0 1  00 */ },
 	}
 };
 EXPORT_SYMBOL(dvb_pll_tda665x);

--
