Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSH3Wrv>; Fri, 30 Aug 2002 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSH3Wru>; Fri, 30 Aug 2002 18:47:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1715 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313305AbSH3Wru>;
	Fri, 30 Aug 2002 18:47:50 -0400
Date: Fri, 30 Aug 2002 15:43:50 -0700 (PDT)
Message-Id: <20020830.154350.04695094.davem@redhat.com>
To: vojtech@suse.cz
Cc: rmk@arm.linux.org.uk, jsimmons@transvirtual.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31-serport
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020831003618.B33615@ucw.cz>
References: <E17ktTz-000359-00@flint.arm.linux.org.uk>
	<20020830.150359.16679671.davem@redhat.com>
	<20020831003618.B33615@ucw.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Vojtech Pavlik <vojtech@suse.cz>
   Date: Sat, 31 Aug 2002 00:36:18 +0200
   
   No, but using serport.c, you can bind a serio to a tty via a line
   discipline, for example if you want a PC serial mouse on /dev/ttyS0 to
   talk to sermouse.c via serio. I don't like the approach much, I hope(d) we
   could switch somewhere below the tty layer, but it sort of works, and
   maybe will have the bugs fixed sooner or later.

So how about this:

1) When SERIO device is claimed, we fail of TTY copy is opened
   by any user.

2) Once we allow SERIO device to be claimed, we prevent opens
   of TTY copy.

I guess this is sort of what Russell is recommending.
