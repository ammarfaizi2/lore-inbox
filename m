Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281199AbRKLXn2>; Mon, 12 Nov 2001 18:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKLXnT>; Mon, 12 Nov 2001 18:43:19 -0500
Received: from jalon.able.es ([212.97.163.2]:47856 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281199AbRKLXnK>;
	Mon, 12 Nov 2001 18:43:10 -0500
Date: Tue, 13 Nov 2001 00:43:03 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113004303.C1531@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 12, 2001 at 20:01:56 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011112 Linus Torvalds wrote:
>
>Ok, this kernel hopefully contains all the high-priority merges with Alan,
>which means that as far as that is concerned, I'm done with 2.4.x and
>ready to pass it on to Marcelo.
>
>Which means that I'd also like people to double-check that there are no
>embarrassing missing pieces due to the merge (or other patches).
>

This bit is in Alan's but not in your tree (also is in original aic-6.2.4):

diff -u -r -N linux-2.4.12.virgin/drivers/scsi/scsi_error.c linux-2.4.12/drivers/scsi/scsi_error.c
--- linux-2.4.12.virgin/drivers/scsi/scsi_error.c	Sun Sep  9 11:52:35 2001
+++ linux-2.4.12/drivers/scsi/scsi_error.c	Thu Oct 11 13:57:36 2001
@@ -1009,13 +1009,7 @@
 			SCpnt->flags &= ~IS_RESETTING;
 			goto maybe_retry;
 		}
-		/*
-		 * Examine the sense data to figure out how to proceed from here.
-		 * If there is no sense data, we will be forced into the error
-		 * handler thread, where we get to examine the thing in a lot more
-		 * detail.
-		 */
-		return scsi_check_sense(SCpnt);
+		return SUCCESS;
 	default:
 		return FAILED;
 	}

Is really needed ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre3-beo #1 SMP Mon Nov 12 00:04:41 CET 2001 i686
