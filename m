Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTF0VDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTF0VDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:03:52 -0400
Received: from web12304.mail.yahoo.com ([216.136.173.102]:5921 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264801AbTF0VDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:03:50 -0400
Message-ID: <20030627211805.46684.qmail@web12304.mail.yahoo.com>
Date: Fri, 27 Jun 2003 14:18:05 -0700 (PDT)
From: Mike Keehan <mike_keehan@yahoo.com>
Subject: Re: Synaptics driver on HP6100 and 2.5.73
To: linux-kernel@vger.kernel.org
In-Reply-To: <1056747301.654.0.camel@zarquon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some progress.

I added a "%#x" to the printk for the "..driver lost sync.." message,
and got these results logged:-

 kernel: Synaptics driver lost sync at 1st byte(0x18)
 kernel: Synaptics driver lost sync at 1st byte(0xff)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x18)
 kernel: Synaptics driver lost sync at 1st byte(0xff)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x18)
 kernel: Synaptics driver lost sync at 1st byte(0xfe)
 kernel: Synaptics driver lost sync at 1st byte(0x0)

Pressing one of the left buttons gives:-
 kernel: Synaptics driver lost sync at 1st byte(0x9)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x0)

and releasing it:-
 kernel: Synaptics driver lost sync at 1st byte(0x8)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x0)

while wiping a finger across the pad:-
 kernel: Synaptics driver lost sync at 1st byte(0x8)
 kernel: Synaptics driver lost sync at 1st byte(0x1)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x8)
 kernel: Synaptics driver lost sync at 1st byte(0x3)
 kernel: Synaptics driver lost sync at 1st byte(0x1)
 kernel: Synaptics driver lost sync at 1st byte(0x8)
 kernel: Synaptics driver lost sync at 1st byte(0x2)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x8)
 kernel: Synaptics driver lost sync at 1st byte(0x2)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
 kernel: Synaptics driver lost sync at 1st byte(0x28)
 kernel: Synaptics driver lost sync at 1st byte(0x3)
 kernel: Synaptics driver lost sync at 1st byte(0xff)
 kernel: Synaptics driver lost sync at 1st byte(0x28)
 kernel: Synaptics driver lost sync at 1st byte(0x2)
 kernel: Synaptics driver lost sync at 1st byte(0xff)
 kernel: Synaptics driver lost sync at 1st byte(0x8)
 kernel: Synaptics driver lost sync at 1st byte(0x4)
 kernel: Synaptics driver lost sync at 1st byte(0x0)
... (lots more)

It looks like the protocol is three bytes per 'event' and the nibbles
have been swapped in the bytes from this touchpad!

Mike.


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
