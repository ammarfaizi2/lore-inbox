Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUBMCd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUBMCd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:33:59 -0500
Received: from CPE-65-28-18-238.kc.rr.com ([65.28.18.238]:62374 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S266685AbUBMCd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:33:58 -0500
Message-ID: <52496.192.168.1.12.1076639642.squirrel@mail.2thebatcave.com>
In-Reply-To: <E1ArSm1-0003ei-Pv@localhost>
References: <1oAMR-6St-13@gated-at.bofh.it> <E1ArSm1-0003ei-Pv@localhost>
Date: Thu, 12 Feb 2004 20:34:02 -0600 (CST)
Subject: Re: getting usb mass storage to finish before running init?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, the root filesystem is an initrd, so I can't do that.

I suppose I could compile in the extra info for /proc/partitions and see
if that gives me anything I can keep looking for (don't know if it puts
file system labels in there, but that is probably what I would have to go
on since that is really the only thing that is constant on all systems).

Is there a quick/clean way to query a device and get the label?  I suppose
I could use tune2fs or something, but I didn't know if there is anything
better/simpler.  I don't know if I like the idea of running tune2fs on
each partition again and again.  I guess I could keep a list in memory and
only check each one once, but that is getting a bit more complicated &
time consuming.


>
> Check available devices for root filesystem (in case you're booting
> from IDE). If it's not there, wait a moment, then look for additional
> devices. If nothing shows up, repeat.
>
> --
> Ciao,
> Pascal
>

