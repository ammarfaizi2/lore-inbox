Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTJEUmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTJEUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 16:42:16 -0400
Received: from msdo0001.xtend.de ([217.27.0.68]:31676 "EHLO msdo0001.xtend.de")
	by vger.kernel.org with ESMTP id S263848AbTJEUmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 16:42:12 -0400
Message-ID: <3F808216.3090106@triaton-webhosting.com>
Date: Sun, 05 Oct 2003 22:41:58 +0200
From: Georg Chini <georg.chini@triaton-webhosting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux sparc64; en-US; rv:1.4a) Gecko/20030510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SPARC64 and 32: Several problems with 2.6.0-test5 and test6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did some testing with test5 and test6 kernels on
my Sparc Ultra1 and Sparcstation 5. Here is a summary
of the problems I observed. Maybe this helps to fix
things.

1) Keyboard:
    On both architectures the Sun type 5 keyboard
    (and mouse) will not be found.

2) Console:
    On both architectures only PROM-console will work. The
    system will not switch to serial (Ultra1) or TCX (SS5)
    console.
    Sending break gives no ok-prompt.

3) Netfilter on sparc64:
    Any iptables command except iptables -L crashes my
    system without further messages. I am already in contact with
    Harald Welte about this (see netfilter-devel list).

4) Compile on sparc32
    The function sched_clock is missing in time.c.
    There is a posting by Andrew Morton on this list
    which defines the function. The kernel compiles
    and boots with this patch.
    When compiling modules I get following unresolved
    symbols in various modules in stage 2:

   .div
   .rem
   .udiv
   .umul
   .urem
   ___atomic_add
   ___atomic_sub
   ___clear_bit
   ___set_bit
   prom_apply_generic_ranges
   prom_halt
   prom_printf
   sparc_flush_page_to_ram
   sun_do_break

    I think I could fix this myself if anyone can tell me where
    to find an example.

    Regards
            Georg Chini

