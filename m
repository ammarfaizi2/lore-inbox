Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288763AbSANSkm>; Mon, 14 Jan 2002 13:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSANSkd>; Mon, 14 Jan 2002 13:40:33 -0500
Received: from webcon.net ([216.187.106.140]:35258 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S288763AbSANSjb>;
	Mon, 14 Jan 2002 13:39:31 -0500
Date: Mon, 14 Jan 2002 13:39:24 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide.2.4.16.12102001 chokes on HPT366
In-Reply-To: <Pine.LNX.4.10.10201132041350.18708-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.40.0201141336480.2591-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Andre Hedrick wrote:

> Quantum Fireball LM30 -- stuff it in a quirk list in the top of the file
> and see if that fixes it.

--- hpt366.c~	Sun Jan 13 18:38:52 2002
+++ hpt366.c	Mon Jan 14 01:24:55 2002
@@ -82,7 +82,8 @@
 	"QUANTUM FIREBALLP KA6.4",
 	"QUANTUM FIREBALLP LM20.4",
 	"QUANTUM FIREBALLP LM20.5",
-        NULL
+	"QUANTUM FIREBALLP LM30",
+	NULL
 };

 const char *bad_ata100_5[] = {


... made no difference. Also tried ignoring the speed test and running the
system as usual, but it consistently locks up during high disk IO.

Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------

