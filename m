Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTAFHlu>; Mon, 6 Jan 2003 02:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTAFHlt>; Mon, 6 Jan 2003 02:41:49 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:18878 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266297AbTAFHlq>; Mon, 6 Jan 2003 02:41:46 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, davem@redhat.com,
       dwmw2@redhat.com
Subject: Re: [SERIAL] change_speed -> settermios change
References: <20030103161916.A19992@flint.arm.linux.org.uk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 Jan 2003 16:49:58 +0900
In-Reply-To: <20030103161916.A19992@flint.arm.linux.org.uk>
Message-ID: <buo7kdibtuh.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks OK to me; as soon as you decide how the low-level driver should
limit the baud rate, I'll update nb85e_uart.c to do it (storing max/min in
the uart_port structure, as someone suggested, seems pretty convenient).

If unsupported termios flags are passed in, what should the low-level
function do?  Tweak the contents of *termios to reflect reality?

BTW, why the name `settermios'?  Something like `set_termios' seems easier
to read and more in keeping with the style used elsewhere in the
serial-port code.  [settermios brings back horrible memories of BSD kernel
code...]

Thanks,

-miles
-- 
Run away!  Run away!
