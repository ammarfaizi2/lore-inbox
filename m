Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273877AbRJKIlL>; Thu, 11 Oct 2001 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273857AbRJKIlB>; Thu, 11 Oct 2001 04:41:01 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32943 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273836AbRJKIks>; Thu, 11 Oct 2001 04:40:48 -0400
Date: Thu, 11 Oct 2001 09:41:18 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Uhhuh.. 2.4.12
Message-ID: <20011011094118.M10562@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com> <9q3lbs$16o$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9q3lbs$16o$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 11, 2001 at 08:30:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 08:30:52AM +0000, Linus Torvalds wrote:

> In article <Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com>,
> Linus Torvalds  <torvalds@transmeta.com> wrote:
> >
> >So I made a 2.4.12, and renamed away the sorry excuse for a kernel that
> >2.4.11 was.
> >
> > - Tim Waugh: parport update
> 
> .. which is broken.
> 
> Not a good week. 

Here is the fix:

--- linux/drivers/parport/ieee1284_ops.c.orig	Thu Oct 11 09:40:39 2001
+++ linux/drivers/parport/ieee1284_ops.c	Thu Oct 11 09:40:42 2001
@@ -362,7 +362,7 @@
 	} else {
 		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 	return retval;
@@ -394,7 +394,7 @@
 		DPRINTK (KERN_DEBUG
 			 "%s: ECP direction: failed to switch forward\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 
Sorry guys. *blush*

Tim.
*/
