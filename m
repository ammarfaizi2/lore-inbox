Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWCOTiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWCOTiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCOTiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 14:38:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44237 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750910AbWCOTiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 14:38:06 -0500
Date: Wed, 15 Mar 2006 14:38:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Adrian Bunk <bunk@stusta.de>
cc: mchehab@infradead.org, <mdharm-usb@one-eyed-alien.net>,
       <v4l-dvb-maintainer@linuxtv.org>, <video4linux-list@redhat.com>,
       <usb-storage@lists.one-eyed-alien.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.16-rc: saa7134 + usb-storage = freeze
In-Reply-To: <20060315185152.GA4454@stusta.de>
Message-ID: <Pine.LNX.4.44L0.0603151435340.6203-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006, Adrian Bunk wrote:

> My computer always freezes after a few minutes with the following 
> workload:
> - watching TV with xawtv
> - backup to an external USB disk using backup2l
> 
> As long as I'm not doing both at the same time there are no problems.
> 
> Freeze means:
> - X is completely frozen
> - TV sound continues to be correctly played (the TV card and the 
>   internal sound chip are connected through an external cable)
> - the light of the USB enclosure flashes at about twice per second
> 
> This problem is present in both 2.6.16-rc6-mm1 and 2.6.16-rc5
> (the latter with a patch to support my saa7134 card).
> 
> dmesg is below.
> 
> Any hints how to find the source of this problem?

It's not obvious, at least, not to me.

One possibility is that the combination of the USB backup and the TV 
activity is overloading the PCI bus, and instead of failing gracefully it 
crashes the whole machine.  If that is the reason, it will be very hard to 
prove.  Or fix.

Alan Stern

