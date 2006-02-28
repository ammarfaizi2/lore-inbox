Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWB1FNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWB1FNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWB1FNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:13:35 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:45245 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1750832AbWB1FNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:13:35 -0500
Date: Tue, 28 Feb 2006 14:13:27 +0900 (JST)
Message-Id: <20060228.141327.15247991.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Subject: SPI: cs_change usage
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  Now I'm looking into new SPI subsystem and I have a question.

In spi.h, cs_change's usage is described as follows:

> * (i) If the transfer isn't the last one in the message, this flag is
> * used to make the chipselect briefly go inactive in the middle of the
> * message.  Toggling chipselect in this way may be needed to terminate
> * a chip command, letting a single spi_message perform all of group of
> * chip transactions together.
> *
> * (ii) When the transfer is the last one in the message, the chip may
> * stay selected until the next transfer.  This is purely a performance
> * hint; the controller driver may need to select a different device
> * for the next message.

I'm confused by the last paragraph.  In the last transfer, does
"cs_change = 1" mean "keep the chipselect activated" ?  Or the
paragraph is saying "I can set cs_change to zero to keep the
chipselect activated after the message" ?

---
Atsushi Nemoto
