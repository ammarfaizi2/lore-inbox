Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbTHYCgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 22:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTHYCgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 22:36:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41964 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261385AbTHYCgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 22:36:43 -0400
Message-ID: <3F497614.4090600@pobox.com>
Date: Sun, 24 Aug 2003 22:36:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: via rhine network failure on 2.6.0-test4
References: <3F491E69.5090206@austin.rr.com>
In-Reply-To: <3F491E69.5090206@austin.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> The via rhine driver fails to get a dhcp address on my test system on 
> 2.6.0-test4.   ethereal shows no dhcp request leaving the box but 
> ifconfig does show the device and it is detected in /proc/pci.   
> Switching from the test3 vs.  test4 snapshots built with equivalent 
> configure options on the same system (SuSE 8.2) - test3 works but test4 
> does not.   This is using essentially the default config for both the 
> test3 and test4 cases - the only changes are SMP disabled, scsi devices 
> disabled, Athlon, via-rhine enabled in network devices and a handful of 
> additional filesystems enabled, debug memory allocations enabled.   This 
> is the first time in many months that I have seen problems with the 
> via-rhine driver on 2.6
> 
> Analyzing the code differences between 2.6.0-test3 and test4 (in 
> via-rhine.c) is not very promising since the only line that has changed 
> (kfree to free_netdev) is in the routine via_rhine_remove_one that seems 
> unlikely to cause problems sending data on the network.
> 
> Ideas as to what could have caused the regression?


Does /proc/interrupts show any interrupts being received on your eth 
device?  Does dmesg report any irq assignment problems, or similar?

This sounds like ACPI or irq routing related.

	Jeff



