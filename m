Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTHZW4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbTHZW4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:56:21 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:35332 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262951AbTHZW4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:56:20 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Tom Marshall <tommy@home.tig-grr.com>
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
Date: Wed, 27 Aug 2003 00:56:33 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308270056.33190.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can you please retest with -test4 and russell's yenta patches?
http://patches.arm.linux.org.uk/pcmcia/yenta-20030817.tar

if that doesn't work out: could you please add these lines to in yenta_socket.c?

in yenta_events(), before return:
printk("yenta_events: socket %p, cb: %x, csc: %x\n", socket, cb_event, csc);

in yenta_get_status(), before return:
printk("yenta_get_status: socket %p, state: %x\n", socket, state);


and then report the output on boot, when removig, inserting, cardctl eject, cardctl insert?
this could give an idea what's going on....

rgds
-daniel

