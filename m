Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWCKXYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWCKXYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWCKXYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:24:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46502 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750825AbWCKXYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:24:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on AMD64
Date: Sun, 12 Mar 2006 00:24:04 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, "Discuss x86-64" <discuss@x86-64.org>,
       Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603120024.04938.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the 2.6.16-rc5-mm3 kernel w/ the patch

revert-x86_64-mm-i386-early-alignment.patch

applied I'm able to hang my box (Asus L5D, 1 CPU, x86-64 kernel) solid
by running OpenOffice.org from under KDE (100% of the time but on one
user account only).  Before it hangs I get something like this on the serial console:

BUG: spinlock bad magic on CPU#0, soffice.bin/5293
 lock: ffff81005e174e28, .magic: 000001ff, .owner: .5).@4).06)./0, .owner_cpu: -2141827648
BUG: spinlock lockup on CPU#0, soffice.bin/5293, ffff81005e174e28

Greetings,
Rafael
