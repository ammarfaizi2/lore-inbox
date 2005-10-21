Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVJUGOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVJUGOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVJUGOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:14:18 -0400
Received: from mail.seiko-p.net ([219.101.171.68]:9970 "EHLO mail.seiko-p.net")
	by vger.kernel.org with ESMTP id S964886AbVJUGOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:14:17 -0400
Date: Fri, 21 Oct 2005 15:13:53 +0900
From: "S.OHNOYA" <s.ohnoya@hotmail.co.jp>
To: linux-kernel@vger.kernel.org
Subject: do_nanotime() returns incorrect value.
Message-Id: <20051021151300.E016.S.OHNOYA@hotmail.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.03 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

 I have a problem around timer.

 The problem is ...

 The function do_nanotime() returns incorrect value.
 The value is 414528697ns longer than timer interval(10ms). It occurs few times a day.
 do_poor_nanotime() (in arch/i386/kernel/time.c) is called as do_nanotime().
 do_nanotime() is called within interrupt via rs_interrupt_single() (in drivers/char/serial.c).

 The kernel version is 2.4.21 with PPSKit 2.1.2.
 Architecture is i386 and MPU is PentiumIII 850MHz.
 My computer has two PPS inputs and there are connected to Rb Atomic Clock.

 Does anyone has some advices for resolv this problem?

 Thanks.

