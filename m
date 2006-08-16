Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWHPO6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHPO6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHPO6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:58:05 -0400
Received: from arrakeen.ouaza.com ([212.85.152.62]:55976 "EHLO
	arrakeen.ouaza.com") by vger.kernel.org with ESMTP id S1751199AbWHPO6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:58:04 -0400
Date: Wed, 16 Aug 2006 16:57:38 +0200
From: Raphael Hertzog <hertzog@debian.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060816145738.GA6575@ouaza.com>
References: <20060816104559.GF4325@ouaza.com> <20060816143147.GC13641@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060816143147.GC13641@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Lennart Sorensen wrote:
> In my experience, the way to avoid overruns on a serial port was to use
> a buffered serial port UART (such as a 16550A for example).  I remember
> my 486 wasn't reliable about 19200 or 38400 (depending on how busy the
> cpu was) when using an 8250.  Using a 16550A based card and I could do
> 115200 without any issues since the UART had a 16 byte buffer to help
> out the system.  Unless your 386 has an add in card for the serial port,
> it almost certainly has a very crappy UART and it would be very hard to
> make it work reliably at higher speeds.

I forgot to mention the kind of UART in my mail but it is a 16650A (and
configured as such and detected as such) and I have overruns nevertheless.

bash-2.05a# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:31 rx:7 RTS|CTS|DTR|DSR
1: uart:16550A port:000002F8 irq:3 tx:24 rx:7 RTS|CTS|DTR|DSR

(here there's no overrun but I almost didn't use the serial port since
last reboot)

Cheers,
-- 
Raphaël Hertzog

Premier livre français sur Debian GNU/Linux :
http://www.ouaza.com/livre/admin-debian/
