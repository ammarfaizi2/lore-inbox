Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFFX0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFFX0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:26:03 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:16521 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262361AbTFFX0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:26:02 -0400
Message-Id: <200306062339.h56NdIsG002820@ginger.cmf.nrl.navy.mil>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: "David S. Miller" <davem@redhat.com>, wa@almesberger.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 14:54:06 PDT."
             <20030606215406.GE21217@gaz.sfgoth.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 19:37:29 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606215406.GE21217@gaz.sfgoth.com>,Mitchell Blank Jr writes:
>The really gross part is that it uses kernel-land pointers as "opaque" VC
>descriptors, so basically if atmsigd goes nuts in can easily stomp all
>over the kernel's memory.  Way back when I added a CAP_SYS_RAWIO check to
>the ATMSIGD_CTRL ioctl so at least there's no security hole but it's still
>damn gross (no offense, Werner :-)

yes, it pretty awful.  the problem is that this will take some changes
to user space stuff as well to be done right.  so i was hoping to put
it off till 2.7 and hopefully get something that's smp stable for 
2.6.

>I agree that fixing that old cruft would be a lot more productive than
>trying to shoehorn the ATM devices into the netdevice framework.

i would be willing to review patches.  my concern is to have something
stable for 2.6.  making atm more compliant with the netdevice framework
will make it easier to maintain in the future (or so i hope).
