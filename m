Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJJBrC>; Tue, 9 Oct 2001 21:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273648AbRJJBqw>; Tue, 9 Oct 2001 21:46:52 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:19188 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S273565AbRJJBql>;
	Tue, 9 Oct 2001 21:46:41 -0400
Date: Tue, 9 Oct 2001 18:47:00 -0700
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RFC : Wireless Netlink events
Message-ID: <20011009184700.B16874@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Somebody asked me if it was possible to monitor wireless
configuration change on 802.11 interfaces.
	Looking into the kernel, I noticed that RTnetlink was the
prefered way to export events related to interface changes. So, I
quickly hacked some RTnetlink Wireless Events, and it basically work
the way I want.

	Now, I've got some questions :
	o Have I done it the right way ? Is there anything I forgot ?
	o Is there a way to do a reverse of SIOCGIFINDEX ? If you have
an interface index, how do you get its name ?
	o Should I put the full interface name in the event ? That
would make events larger but help query the interface when receiving
the event.
	o Any other comments ?

	My plan is to continue experimenting with this patch a few
days and collect comments, and then do a new update of Wireless
Extensions with this patch.
	Regards,

	Jean
