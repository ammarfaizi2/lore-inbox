Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVCUVPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVCUVPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVCUVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:13:18 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:2439 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261898AbVCUVEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:04:14 -0500
Date: Mon, 21 Mar 2005 22:04:11 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: S2R gone with 2.6.12-rc1-mm1
Message-ID: <20050321210411.GB29072@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

Sorry to bother you again, but I found that S2R does not work anymore
with 2.6.12-rc1-mm1, while it works with the exact same software setup
with 2.6.11-mm4.

I unload the whole usb stuff (otherwise 2.6.11-mm4 won't work) and do
exactely the same.

The differences in the kernel config files are trivial:

new stuff I answered with yes:
+CONFIG_ACPI_HOTKEY=y
+CONFIG_PCMCIA_IOCTL=y
+CONFIG_AOE_PARTITIONS=16

stuff that has automatically changed (changed Kconfig I suppose)
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y

and some modules I compiled but not use/load.

With 2.6.12-rc1-mm1 the system starts, then nothing, black screen, no
CapsLock light, no Sysrq, no sync hard disk led activity, just plane
frozen.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WINKLEY (n.)
A lost object which turns up immediately you've gone and bought a
replacement for it.
			--- Douglas Adams, The Meaning of Liff
