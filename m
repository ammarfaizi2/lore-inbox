Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272130AbTHDTUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272135AbTHDTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:20:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:32910 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272130AbTHDTUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:20:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.45532.487890.571664@gargle.gargle.HOWL>
Date: Mon, 4 Aug 2003 21:19:56 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [APM ERROR-REPORT] APM_DISPLAY_BLANK freezes Thinkpad R40 and Sony Z1 on suspend
In-Reply-To: <20030804180559.GA31178@puettmann.net>
References: <20030804180559.GA31178@puettmann.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann writes:
 > enable CONFIG_APM_DISPLAY_BLANK on linux 2.4.22-pre10 and
 > 2.4.22-pre10-ac1 freeze my Thinkpad R40 with Ati Mobile 7500 and Sony Z1
 > on apm -s.

If you have UP_APIC or SMP enabled, then this is a known user-bug.
CONFIG_APM_DISPLAY_BLANK, CONFIG_APM_CPU_IDLE, and configuring APM
as a module instead of built-in, are known to do really bad things
with regard to BIOSen and the local APIC.

The fix, if you have APIC or SMP support, is to NOT misconfigure APM.

/Mikael
