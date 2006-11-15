Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030761AbWKORj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030761AbWKORj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030763AbWKORj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:39:58 -0500
Received: from ns.suse.de ([195.135.220.2]:28576 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030762AbWKORj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:39:57 -0500
Date: Wed, 15 Nov 2006 18:40:17 +0100
From: Karsten Keil <kkeil@suse.de>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: isdn4linux@listserv.isdn4linux.de, info@formula-n.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  fix build error for HISAX_NETJET
Message-ID: <20061115174017.GB5158@pingi.kke.suse.de>
Mail-Followup-To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
	isdn4linux@listserv.isdn4linux.de, info@formula-n.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611151808.56562.toralf.foerster@gmx.de>
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a build error for the  enter:now PCI card.

Acked-by: Karsten Keil <kkeil@suse.de>
Signed-off-by: Toralf Förster <toralf.foerster@gmx.de>

diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index eb57a98..cfd2718 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -344,7 +344,7 @@ config HISAX_HFC_SX

 config HISAX_ENTERNOW_PCI
        bool "Formula-n enter:now PCI card"
-       depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
+       depends on HISAX_NETJET && PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
        help
          This enables HiSax support for the Formula-n enter:now PCI
          ISDN card.



-- 
Karsten Keil
SuSE Labs
ISDN development
