Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUBFNq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265457AbUBFNq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:46:29 -0500
Received: from sole.infis.univ.trieste.it ([140.105.134.1]:36553 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id S265452AbUBFNqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:46:21 -0500
Date: Fri, 6 Feb 2004 14:46:19 +0100
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: linux-kernel@vger.kernel.org
Subject: PATCH: I2C is missing on 2.6.2 with ppc arch
Message-ID: <20040206134619.GA23338@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

i2c support is missing on 2.6.2 with ppc arch, it was present on 2.6.1 and
it's needed for many things, most notably dmasound_pmac support.


Here's a patch that fix the problem:

--- Kconfig.orig	2004-02-06 14:40:23.452443000 +0100
+++ Kconfig	2004-02-06 14:36:59.412443000 +0100
@@ -1255,6 +1255,8 @@ endmenu
 
 source "drivers/char/Kconfig"
 
+source "drivers/i2c/Kconfig"
+
 source "drivers/media/Kconfig"
 
 source "fs/Kconfig"


Bye


--
------------------------------------------------------------
INFIS Network Administrator & Security Officer         .*. 
Department of Physics       - University of Trieste     V 
lcars@infis.univ.trieste.it - GPG Key 0x864C9B9E      (   )
----------------------------------------------------  (   )
"How would you know I'm mad?" said Alice.             ^^-^^
"You must be,'said the Cat,'or you wouldn't have come here."
------------------------------------------------------------
