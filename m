Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264433AbRFICdt>; Fri, 8 Jun 2001 22:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264434AbRFICd3>; Fri, 8 Jun 2001 22:33:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:50182 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264433AbRFICdW>;
	Fri, 8 Jun 2001 22:33:22 -0400
Date: Fri, 8 Jun 2001 23:33:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Woller, Thomas" <twoller@crystal.cirrus.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: no sound with CS4281 card
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C0124F2D7@csexchange.crystal.cirrus.com>
Message-ID: <Pine.LNX.4.21.0106082331170.10415-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2001, Woller, Thomas wrote:

> I'll send the latest driver that I have via separate email.  Toshiba
> refuses to supply equipment, and there are some design issues with
> Toshiba laptops.

It turned out a one-liner change to the in-kernel driver
also worked (I was on holidays for a week, so I only see
this email after I got the thing to work ;))

--- linux-2.4.5-ac2/drivers/sound/cs4281/cs4281m.c.orig	Fri Jun  1 09:19:57 2001
+++ linux-2.4.5-ac2/drivers/sound/cs4281/cs4281m.c	Fri Jun  1 09:20:57 2001
@@ -658,7 +658,7 @@
 	       card->pBA0 + BA0_ACCTL);
 
 	// Wait for the write to occur.
-	for (count = 0; count < 10; count++) {
+	for (count = 0; count < 100; count++) {
 		// First, we want to wait for a short time.
 		udelay(25);
 		// Now, check to see if the write has completed.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

