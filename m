Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEWXLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEWXLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVEWXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:09:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2507 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261183AbVEWW4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:56:04 -0400
Message-ID: <42925F7F.2000809@pobox.com>
Date: Mon, 23 May 2005 18:55:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Haumesser <chris@mail-test.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: promise sx8 sata driver
References: <42924E38.7070003@mail-test.us>
In-Reply-To: <42924E38.7070003@mail-test.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Haumesser wrote:
> The sx8 driver does not use libata, and it is a separate block device,
> outside of the scsi and ata hierarchies.  If I compile the driver into
> my kernel, I end up with /dev/sx8/0 and /dev/sx8/0p1, etc.  However, no
> scsi disk devices are created, and grub does not recognize that
> /dev/sx8/ devices are disks.  There's no indication in /proc/scsi/ that
> they are being registered with the scsi subsystem; this is clearly
> different from every other sata controller I've used.  I've been
> googling this for days, with no real luck.  I have found changelogs for
> grub that suggest that my version (0.95) should support booting from the
> sx8.

sx8 is a separate block driver, and has nothing whatsoever to do with scsi.


> So my question is, how does one use this driver for sata disks?  Is my
> problem a grub problem, or does it have something to do with the fact

a grub problem


> What is the relationship between the promise driver and the one included
> in the kernel?  Why does one work differently from the other?  Is there

Promise SX8 provides neither an ATA nor SCSI interface to the developer, 
so its not written as an ATA or SCSI driver.

	Jeff


