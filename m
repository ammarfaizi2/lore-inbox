Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTFPSqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFPSoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:44:10 -0400
Received: from palrel11.hp.com ([156.153.255.246]:45803 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264188AbTFPSng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:43:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16110.4883.885590.597687@napali.hpl.hp.com>
Date: Mon, 16 Jun 2003 11:57:23 -0700
To: "Riley Williams" <Riley@Williams.Name>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <BKEGKPICNAKILKJKMHCAOEGHEFAA.Riley@Williams.Name>
References: <20030614231455.A26303@ucw.cz>
	<BKEGKPICNAKILKJKMHCAOEGHEFAA.Riley@Williams.Name>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 15 Jun 2003 11:51:00 +0100, "Riley Williams" <Riley@Williams.Name> said:

  Riley> 2. The IA64 arch didn't define CLOCK_TICK_RATE at all, but
  Riley> then used the 1193182 value as a magic value in several
  Riley> files. I've inserted that as the definition thereof in
  Riley> timex.h for that arch.

AFAIK, on ia64, it makes absolutely no sense at all to define this
magic CLOCK_TICK_RATE in timex.h.  There simply is nothing in the ia64
architecture that requires any timer to operate at 1193182 Hz.

If there are drivers that rely on the frequency, those drivers should
be fixed instead.

Please do not add CLOCK_TICK_RATE to the ia64 timex.h header file.

	--david
