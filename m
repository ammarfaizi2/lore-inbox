Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADXq7>; Thu, 4 Jan 2001 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRADXqt>; Thu, 4 Jan 2001 18:46:49 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:31678 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129183AbRADXqd>; Thu, 4 Jan 2001 18:46:33 -0500
Date: Thu, 4 Jan 2001 18:46:23 -0500
From: Bill Nottingham <notting@redhat.com>
To: Ignacio Monge <ignaciomonge@navegalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0-prerelease-ac6 compile errors
Message-ID: <20010104184622.A31687@nostromo.devel.redhat.com>
Mail-Followup-To: Ignacio Monge <ignaciomonge@navegalia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010104232253Z129348-400+400@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104232253Z129348-400+400@vger.kernel.org>; from ignaciomonge@navegalia.com on Fri, Jan 05, 2001 at 12:17:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignacio Monge (ignaciomonge@navegalia.com) said: 
> Problem: compile error in linux-2.4.0-prerelease-ac6

--- linux/drivers/char/serial.c.foo	Thu Jan  4 17:31:43 2001
+++ linux/drivers/char/serial.c	Thu Jan  4 17:32:38 2001
@@ -5184,12 +5184,12 @@
 	       
 	       for (pnp_board = pnp_devices; pnp_board->vendor; pnp_board++)
 		       if ((dev->vendor == pnp_board->vendor) &&
-			   (dev->device == pnp_board->device))
+			   (dev->device == pnp_board->function))
 			       break;
 
 	       if (pnp_board->vendor) {
 		       board.vendor = pnp_board->vendor;
-		       board.device = pnp_board->device;
+		       board.device = pnp_board->function;
 		       /* Special case that's more efficient to hardcode */
 		       if ((board.vendor == ISAPNP_VENDOR('A', 'K', 'Y') &&
 			    board.device == ISAPNP_DEVICE(0x1021)))

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
