Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbRAFKWC>; Sat, 6 Jan 2001 05:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130427AbRAFKVw>; Sat, 6 Jan 2001 05:21:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130133AbRAFKVk>;
	Sat, 6 Jan 2001 05:21:40 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101060955.f069t9c18465@flint.arm.linux.org.uk>
Subject: Re: modprobe ipv6 gives -1 usage count was [ramfs problem...]
To: stefan@hello-penguin.com
Date: Sat, 6 Jan 2001 09:55:09 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <20010106062448.A968@stefan.sime.com> from "Stefan Traby" at Jan 06, 2001 06:24:48 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Traby writes:
> I bet that a fix for the following exists, too: :)
> 
> [0]--(06:19:49)-(root@stefan)-(~)-> lsmod |grep -i ipv6
> [1]--(06:22:33)-(root@stefan)-(~)-> modprobe ipv6
> [0]--(06:22:38)-(root@stefan)-(~)-> lsmod |grep -i ipv6
> ipv6                  117424  -1 
> [0]--(06:22:46)-(root@stefan)-(~)->
> 
> usage count: -1

Why?  It is not a bug.  It means that the module itself determines when/if
it can be unloaded.  (an attempt to unload ipv6 calls ipv6_unload() which
determines if the module can be removed)
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
