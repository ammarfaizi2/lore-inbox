Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVLMI3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVLMI3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVLMI3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:29:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:34180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932564AbVLMIZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:13 -0500
Date: Tue, 13 Dec 2005 00:22:42 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, r3pek@gentoo.org
Subject: [patch 09/26] DVB: BUDGET CI card depends on STV0297 demodulator
Message-ID: <20051213082242.GJ5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-budget-ci-card-depends-on-stv0297-demodulator.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Drake <dsd@gentoo.org>

This patch solves a DVB driver compile error introduced in 2.6.14

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/dvb/ttpci/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14.3.orig/drivers/media/dvb/ttpci/Kconfig
+++ linux-2.6.14.3/drivers/media/dvb/ttpci/Kconfig
@@ -81,6 +81,7 @@ config DVB_BUDGET_CI
 	tristate "Budget cards with onboard CI connector"
 	depends on DVB_CORE && PCI
 	select VIDEO_SAA7146
+	select DVB_STV0297
 	select DVB_STV0299
 	select DVB_TDA1004X
 	help

--
