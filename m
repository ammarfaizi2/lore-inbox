Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWDEABi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWDEABi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWDEABR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:17 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:13712
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750958AbWDEAAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:55 -0400
Date: Tue, 4 Apr 2006 17:00:11 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linville@tuxdriver.com, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/26] PCMCIA_SPECTRUM must select FW_LOADER
Message-ID: <20060405000011.GI27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pcmcia_spectrum-must-select-fw_loader.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCMCIA_SPECTRUM must select FW_LOADER.

Reported by "Alexander E. Patrakov" <patrakov@ums.usu.ru>.

This patch was already included in Linus' tree.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/wireless/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.1.orig/drivers/net/wireless/Kconfig
+++ linux-2.6.16.1/drivers/net/wireless/Kconfig
@@ -374,6 +374,7 @@ config PCMCIA_HERMES
 config PCMCIA_SPECTRUM
 	tristate "Symbol Spectrum24 Trilogy PCMCIA card support"
 	depends on NET_RADIO && PCMCIA && HERMES
+	select FW_LOADER
 	---help---
 
 	  This is a driver for 802.11b cards using RAM-loadable Symbol

--
