Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbUKKVyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUKKVyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKKVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:53:56 -0500
Received: from alog0088.analogic.com ([208.224.220.103]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262376AbUKKVtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:49:09 -0500
Date: Thu, 11 Nov 2004 16:48:18 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Anthony Samsung <anthony.samsung@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: network interface to driver and pci slot mapping
In-Reply-To: <8874763604111113281b1cf9a5@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0411111640470.11012@chaos.analogic.com>
References: <8874763604111113281b1cf9a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004, Anthony Samsung wrote:

> Given an interface name (like eth0), how do I determine:
> The name of the driver (module) for this interface.
> The PCI address for this interface, if relevant.
>
> ?
>
> I need something that works non-destructively on a live system, that
> isn't broken by nameif, and has a strong chance of producing a correct
> result. In particular, parsing syslog is out. There's no consistency
> in the format of messages and there's no guarantee the logs from
> bootup will still be around. And the interface may have been renamed
> since then.

If the eth0 device is a module, it's in /etc/modprobe.conf, previous
versions used /etc/modules.conf.
Once you have its module name you can use other resources like

/sys/bus/pci/drivers/MODULENAME


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
