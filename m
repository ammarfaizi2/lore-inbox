Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSJUSwX>; Mon, 21 Oct 2002 14:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbSJUSwX>; Mon, 21 Oct 2002 14:52:23 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:19706 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261483AbSJUSwW>; Mon, 21 Oct 2002 14:52:22 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.30.0210210852130.17911-100000@shell.cyberus.ca> 
References: <Pine.GSO.4.30.0210210852130.17911-100000@shell.cyberus.ca> 
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: rtnetlink interface state monitoring problems. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Oct 2002 19:57:50 +0100
Message-ID: <24818.1035226670@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hadi@cyberus.ca said:
> I cant see anything on netlink and irda; i am also not very familiar
> with either IrDA or Bluetooth. Regardless,  you dont need to be a net
> device to use netlink. 

IrDA devices are network devices. The core network code sends a RTM_NETLINK 
message when they go up or down. All is well, and once the permission fix 
gets into the kernel I'm using, my irda monitor applet no longer needs to 
poll the state of the interface.

But Bluetooth devices are not network devices, it seems. There exists no 
current mechanism for notifying anyone of state changes. Should we invent a 
new method of notification using netlink, or should Bluetooth interfaces in 
fact be normal network devices just like IrDA devices are?

--
dwmw2


