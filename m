Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRJKI7V>; Thu, 11 Oct 2001 04:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274133AbRJKI7L>; Thu, 11 Oct 2001 04:59:11 -0400
Received: from jalon.able.es ([212.97.163.2]:31904 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S273912AbRJKI7G>;
	Thu, 11 Oct 2001 04:59:06 -0400
Date: Thu, 11 Oct 2001 10:59:30 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Tim Waugh <twaugh@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Uhhuh.. 2.4.12
Message-ID: <20011011105930.A30133@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com> <9q3lbs$16o$1@penguin.transmeta.com> <20011011094118.M10562@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011011094118.M10562@redhat.com>; from twaugh@redhat.com on Thu, Oct 11, 2001 at 10:41:18 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011011 Tim Waugh wrote:
>On Thu, Oct 11, 2001 at 08:30:52AM +0000, Linus Torvalds wrote:
>
>> In article <Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com>,
>> Linus Torvalds  <torvalds@transmeta.com> wrote:
>> >
>> >So I made a 2.4.12, and renamed away the sorry excuse for a kernel that
>> >2.4.11 was.
>> >
>> > - Tim Waugh: parport update
>> 
>> .. which is broken.
>> 
>> Not a good week. 
>
>Here is the fix:
>
>--- linux/drivers/parport/ieee1284_ops.c.orig	Thu Oct 11 09:40:39 2001
>+++ linux/drivers/parport/ieee1284_ops.c	Thu Oct 11 09:40:42 2001
>@@ -362,7 +362,7 @@
> 	} else {
> 		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
> 			 port->name);
>-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
>+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
> 	}
> 
> 	return retval;
>@@ -394,7 +394,7 @@
> 		DPRINTK (KERN_DEBUG
> 			 "%s: ECP direction: failed to switch forward\n",
> 			 port->name);
>-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
>+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
> 	}
> 

So you are on the work, why don't put out .13 ? And we have a correct tree...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.10-ac11-beo #2 SMP Thu Oct 11 02:41:04 CEST 2001 i686
