Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318859AbSIISzX>; Mon, 9 Sep 2002 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318860AbSIISzX>; Mon, 9 Sep 2002 14:55:23 -0400
Received: from [209.173.6.49] ([209.173.6.49]:34436 "EHLO comet.linuxguru.net")
	by vger.kernel.org with ESMTP id <S318859AbSIISzO>;
	Mon, 9 Sep 2002 14:55:14 -0400
Date: Mon, 9 Sep 2002 07:59:57 -0400
To: linux-kernel@vger.kernel.org
Cc: jonathan@buzzard.org.uk
Subject: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020909115956.GA23290@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: James Blackwell <jblack@linuxguru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere around 2.5.31 the method for setting and clearing interrupts
changed:

From-                     To-
save_flags(flags);        local_irq_save(flags);
cli();

restore_flags(flags);     local_irq_restore(flags);


Though bordering on trivial, including toshiba support with stock 2.5.34
fails to compile, which this patch seems to fix. This patch fixes this
issue and has worked reliably for me under 2.5.31, though it is untested on
2.5.32 and 2.5.33 because I didn't manage to get those to work. 

A note to those that are a bit rough on kernel patch newbies.... submitting 
a kernel patch for the very first time is a rather intimidating experience
so please don't chew my head off unless its absolutely necessary. 




-- 
GnuPG fingerprint AAE4 8C76 58DA 5902 761D  247A 8A55 DA73 0635 7400
James Blackwell  --  Director http://www.linuxguru.net
