Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSEDAyw>; Fri, 3 May 2002 20:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315759AbSEDAyv>; Fri, 3 May 2002 20:54:51 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:19701
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315758AbSEDAyv>; Fri, 3 May 2002 20:54:51 -0400
Message-ID: <3CD33159.942E1EF7@eyal.emu.id.au>
Date: Sat, 04 May 2002 10:54:49 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: 8253xutl.c compile error
In-Reply-To: <20020503203738.E1396@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------37371304A3D107FBBD2316D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------37371304A3D107FBBD2316D3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> 
> Full patchkit:
> 
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz

This problem was in -pre7, fixed in -pre8, yet it is back in -pre8-aa1!

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------37371304A3D107FBBD2316D3
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre8-aa1-8253.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre8-aa1-8253.patch"

--- linux/drivers/net/wan/8253x/8253xutl.c.orig	Fri Apr  5 08:52:00 2002
+++ linux/drivers/net/wan/8253x/8253xutl.c	Fri Apr  5 08:55:47 2002
@@ -1344,7 +1344,6 @@
 	while ((Sab8253xCountTransmit(port) > 0) || !port->all_sent) 
 	{
 		current->state = TASK_INTERRUPTIBLE;
-		current->counter = 0;
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 		{

--------------37371304A3D107FBBD2316D3--

