Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163007AbWLBN4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163007AbWLBN4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 08:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163009AbWLBN4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 08:56:16 -0500
Received: from wylie.me.uk ([82.68.155.89]:25309 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S1163007AbWLBN4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 08:56:16 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17777.34301.958405.967354@wylie.me.uk>
Date: Sat, 2 Dec 2006 13:56:13 +0000
To: linux-kernel@vger.kernel.org
Subject: Confusing stream of atkbd messages after failed boot
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On upgrading to 2.6.19, I didn't bother reading the release notes, did
a "make oldconfig", and rebooted. The boot failed (since the SATA
.config options had been moved) and I was presented with a continous
stream of error messages:

atkbd.c: Spurious ACK on isa0060/serio
  Some program might be trying to access hardware directly.

These seem to be as a result of the keyboard LEDs being flashed.

They cause the real error message:

Cannot open root device

and the preceding kernel messages which show a lack of detection of
the SATA hard drive to be rapidly scrolled off screen.

The atkbd message should at the very least be rate limited.

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
