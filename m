Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263430AbRFKF7k>; Mon, 11 Jun 2001 01:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263434AbRFKF7a>; Mon, 11 Jun 2001 01:59:30 -0400
Received: from netcore.fi ([193.94.160.1]:23055 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S263430AbRFKF7P>;
	Mon, 11 Jun 2001 01:59:15 -0400
Date: Mon, 11 Jun 2001 08:59:10 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106110852570.23217-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Jeff Garzik wrote:
> Initial draft of a helper which uses generic elements present in several
> net drivers to implement ethtool ioctl support in a minimum amount of
> code.

In the patch there is:

@@ -135,6 +139,11 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(debug, "EPIC/100 debug level (0-5)");
+MODULE_PARM_DESC(max_interrupt_work, "EPIC/100 maximum events handled per interrupt");
+MODULE_PARM_DESC(options, "EPIC/100: Bits 0-3: media type, bit 4: full duplex");
+MODULE_PARM_DESC(rx_copybreak, "EPIC/100 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(full_duplex, "EPIC/100 full duplex setting(s) (1)");

I recall some discussion on a list (can't find it now) that driver
specific comment like "EPIC/100" here notification on all _DESC's would be
removed to a separate MODULE_ to make the comments more generic?

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords





