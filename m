Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268726AbTCCTJY>; Mon, 3 Mar 2003 14:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268728AbTCCTJX>; Mon, 3 Mar 2003 14:09:23 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28435 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268726AbTCCTJV>;
	Mon, 3 Mar 2003 14:09:21 -0500
Date: Mon, 3 Mar 2003 20:19:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Tomas Szepe <szepe@pinerecords.com>,
       Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk menuconfig format problem
Message-ID: <20030303191908.GA3609@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tomas Szepe <szepe@pinerecords.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <3E637196.8030708@walrond.org> <20030303175844.A29121@infradead.org> <20030303184906.GF6946@louise.pinerecords.com> <20030303185337.A30585@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303185337.A30585@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 06:53:37PM +0000, Christoph Hellwig wrote:
> Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
> on it's placements.  If people who actually do use if feel that it's placed
> wrongly feel free to submit a patch to fix it.

The following patch moves it to the menu "Processor type & features"
Right before HIMEM.

	Sam

===== arch/i386/Kconfig 1.46 vs edited =====
--- 1.46/arch/i386/Kconfig	Mon Mar  3 03:14:31 2003
+++ edited/arch/i386/Kconfig	Mon Mar  3 20:16:28 2003
@@ -18,15 +18,6 @@
 	bool
 	default y
 
-config SWAP
-	bool "Support for paging of anonymous memory"
-	default y
-	help
-	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unusre say Y.
-
 config SBUS
 	bool
 
@@ -624,6 +615,15 @@
 
 	  This option is experimental, but believed to be safe,
 	  and most disk controller BIOS vendors do not yet implement this feature.
+
+config SWAP
+	bool "Support for paging of anonymous memory"
+	default y
+	help
+	  This option allows you to choose whether you want to have support
+	  for so called swap devices or swap files in your kernel that are
+	  used to provide more virtual memory than the actual RAM present
+	  in your computer. If unsure say Y.
 
 choice
 	prompt "High Memory Support"
