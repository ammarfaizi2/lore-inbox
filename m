Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280398AbRJaSdm>; Wed, 31 Oct 2001 13:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280400AbRJaSdd>; Wed, 31 Oct 2001 13:33:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63108 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280398AbRJaSd0>;
	Wed, 31 Oct 2001 13:33:26 -0500
Date: Wed, 31 Oct 2001 10:32:41 -0800 (PST)
Message-Id: <20011031.103241.45747017.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110311827530.19987-100000@tahallah.demon.co.uk>
In-Reply-To: <20011031.092954.115906622.davem@redhat.com>
	<Pine.LNX.4.33.0110311827530.19987-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Wed, 31 Oct 2001 18:28:28 +0000 (GMT)

   On Wed, 31 Oct 2001, David S. Miller wrote:
   
   >   cp src/linux/include/linux/soundcard.h /usr/include/linux/soundcard.h
   
   Unfortunately, these files are identical, which is why it is so strange!

I'm pretty sure the ioctl numbers are wrong, and that is what
is causing the problem.

Print out from your app the ioctl number it uses (you've done
this already) and have the kernel do similar.  If they are different
you know that at least I was on the right track.

It's easy to figure out some value in the kernel without even
rebooting, just add to like some source file:

int foo = IOCTL_VALUE_I_WANT;

Then do "make drivers/sbus/audio/whatever.s"
and look at the assembler file for the value it
ended up using :-)

Franks a lot,
David S. Miller
davem@redhat.com
