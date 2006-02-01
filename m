Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWBAQBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWBAQBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWBAQBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:01:41 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:46326 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1422655AbWBAQBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:01:40 -0500
Date: Thu, 02 Feb 2006 01:01:18 +0900 (JST)
Message-Id: <20060202.010118.126574883.anemo@mba.ocn.ne.jp>
To: gdavis@mvista.com
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add spin_lock_init() in 8250
 early_serial_setup() to init port.lock
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060201154549.GE7405@mvista.com>
References: <20060126032403.GG5133@mvista.com>
	<20060131.003927.112625901.anemo@mba.ocn.ne.jp>
	<20060201154549.GE7405@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 1 Feb 2006 10:45:49 -0500, "George G. Davis" <gdavis@mvista.com> said:

gdavis> uart_set_options() is only called from
gdavis> serial8250_console_setup() when 8250 serial devices have
gdavis> already been registered via serial8250_isa_init_ports() (for
gdavis> legacy devices only though AFAICT).

OK, I see.  Then, please look at this patch in 2.6.16-rc1-mm4.

serial-initialize-spinlock-for-port-failed-to-setup.patch

Does this fix your problem ?

---
Atsushi Nemoto
