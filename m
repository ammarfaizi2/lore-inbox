Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSJQVAH>; Thu, 17 Oct 2002 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262095AbSJQVAH>; Thu, 17 Oct 2002 17:00:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58558 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262080AbSJQVAG>;
	Thu, 17 Oct 2002 17:00:06 -0400
Date: Thu, 17 Oct 2002 13:58:32 -0700 (PDT)
Message-Id: <20021017.135832.54206778.davem@redhat.com>
To: greg@kroah.com
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017205830.GD592@kroah.com>
References: <20021017203652.GB592@kroah.com>
	<20021017.133816.82029797.davem@redhat.com>
	<20021017205830.GD592@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Thu, 17 Oct 2002 13:58:31 -0700

   I've run the numbers myself on OSDL machines, and seen that there is no
   measurable overhead for these functions.  Sure, there is an extra
   function call, and different assembler, I'll never contest that.  It's
   just that I could not measure it.
   
Did you look at the _code_?  Did you measure the size of even the
non security/*.o object code with/without the hooks?  What is the
added overhead?

2.5.x is busting at the seams currently and CONFIG_SECURITY is part of
the reason why.

   It is adding stuff to the kernel.  Now if you want to call it bloat,
   fine.  I like calling the USB stack bloat too, and it is bloat for
   people who don't use it.

There is a very important fundamental difference to the USB case.
It eats zero space in my kernel when I have no USB devices.
CONFIG_USB=m works as designed!

CONFIG_SECURITY=m still does not exist, so distribution makers have to
make a y vs. n choice.

   Argue with your favorite distro if they enable the option that they
   shouldn't do that, if they do, don't try to convince me.
   
I need to convince you to implement this in a way, so that like
USB, there is zero overhead when I enable it as a module. :-)

   And I know what my true calling in life is, but unfortunately there isn't
   much calling for a professional pan flute player :)
   
:)
