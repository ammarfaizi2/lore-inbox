Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266246AbTAFHCD>; Mon, 6 Jan 2003 02:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTAFHCD>; Mon, 6 Jan 2003 02:02:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21462 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266246AbTAFHCC>;
	Mon, 6 Jan 2003 02:02:02 -0500
Date: Sun, 05 Jan 2003 23:02:18 -0800 (PST)
Message-Id: <20030105.230218.84729944.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, miles@gnu.org, dwmw2@redhat.com
Subject: Re: [SERIAL] change_speed -> settermios change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030103161916.A19992@flint.arm.linux.org.uk>
References: <20030103161916.A19992@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Fri, 3 Jan 2003 16:19:16 +0000
   
   I have one concerns surrounding the three drivers mentioned above.
   Currently, they blindly use uart_get_baud_rate() without limiting the
   maximum baud rate.  Since the baud rate will be limited (by the
   hardware), we must limit the resulting baud rate must be reflected
   back into the termios c_cflag member.

Hmmm, maybe it's a better idea to store the min/max in the UART port
structure and have the upper layer do the limiting before we call
down into the driver?

