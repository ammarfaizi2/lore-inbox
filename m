Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271676AbRHUN6Q>; Tue, 21 Aug 2001 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271680AbRHUN6H>; Tue, 21 Aug 2001 09:58:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56733 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271676AbRHUN57>;
	Tue, 21 Aug 2001 09:57:59 -0400
Date: Tue, 21 Aug 2001 06:58:09 -0700 (PDT)
Message-Id: <20010821.065809.102572680.davem@redhat.com>
To: jes@sunsite.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <d3wv3x8qro.fsf@lxplus015.cern.ch>
In-Reply-To: <d3elq5a6au.fsf@lxplus015.cern.ch>
	<20010821.063900.112292626.davem@redhat.com>
	<d3wv3x8qro.fsf@lxplus015.cern.ch>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jes Sorensen <jes@sunsite.dk>
   Date: 21 Aug 2001 15:51:55 +0200
   
   The much cleaner way to solve this problem is to write a user space
   tool to upgrade the image in the flash ram on the QL with your latest
   favorite image found at www.qlogic.com. It's a 128KB image, you can
   write directly to the flash in two banks by setting the read/write bit
   and setting the 2nd bank bit for the last 64KB.

When the Qlogic,FC sees a master abort, the firmware is essentially
cleared to zero.

This is what was happening to me.

Now what if I cannot boot now because this was on my root block
device.  I cannot even go back to a previous rev of the kernel
I was working on to get it back.

If you're going to say "put the user thing in initrd", I'm going to
say "bite me".  I build a static kernel with no initrd and that is how
I'd like it to stay.  It is one thing to do initrd firmware loading
for devices not necessary for booting and mounting root, that is
acceptable, this isn't.

Jes, I think your arguments are wrong.  I think the driver should
have been removed in whole and replaced with something like this
in qlogicfc.c so everyone would know what the problem is:

/* This driver was removed due to licensing in the firmware
 * which conflicts with the GPL.  The driver is only really
 * fully functional with the firmware included, so instead of
 * breaking half of the qlogic/fc users out there we removed
 * this driver outright.
 */

I would have never sent out the email which started this thread
had this been done.  I would not have questioned anything, and
would have instead said "unfortunate" to myself and left it at
that.

Later,
David S. Miller
davem@redhat.com
