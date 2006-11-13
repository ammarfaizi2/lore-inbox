Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755307AbWKMSNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbWKMSNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbWKMSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:13:54 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:25609 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1755307AbWKMSNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:13:53 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org
Subject: proposal: remove unused macros
Date: Mon, 13 Nov 2006 19:13:21 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131913.22872.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Recently someone send a patch that fixed some old '#ifdef'ed code with syntax 
error (stray brackets). The broken code was there for a long time and nobody 
saw that. I digged some more and wrote a simple program that counted '(' 
and ')' in the kernel code that emits apropriate text if for a given file 
both numbers differ. That is probably dumb idea but it worked :-) Quite fast 
I found a dozen of broken macros with syntax errors etc. All of those macros 
are unused. I digged a bit deeper and used '-Wunused-macros' flag which with 
causes 8340 new warnings to be emited for 2.6.19-rc5-mm1 with 'allmodconfig'. 
For sure there are false positives (see gcc man page) but even if i.e. 50% of 
them are fp then we still have around 4k of unused macros scattered around 
the tree.

To me this is a dead code. I can review the code causing these warnings and 
prepare patches 'per subsystem' or whatever to address this issue. That is if 
nobody opposes.
-- 
Regards,

	Mariusz Kozlowski
