Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSH3WKn>; Fri, 30 Aug 2002 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSH3WJs>; Fri, 30 Aug 2002 18:09:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49586 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317610AbSH3WIF>;
	Fri, 30 Aug 2002 18:08:05 -0400
Date: Fri, 30 Aug 2002 15:03:59 -0700 (PDT)
Message-Id: <20020830.150359.16679671.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: vojtech@ucw.cz, jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31-serport
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17ktTz-000359-00@flint.arm.linux.org.uk>
References: <E17ktTz-000359-00@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Fri, 30 Aug 2002 22:39:11 +0100

   2. What happens if I open and try to read from this port while something
      has the serport_ldisc attached?  I suspect that you'll create nice
      loop of serio devices in serio.c and an infinite loop when you try to
      traverse the list to remove a different serio device.
      
SERIO devices are not meant to be registered as normal TTYs.
At least I don't do this for any of the Sparc serial ports
when they are the keyboard/mouse serio device.
