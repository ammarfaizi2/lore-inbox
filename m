Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbUDASQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUDASQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:16:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263021AbUDASQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:16:36 -0500
Message-ID: <406C5C77.6020300@pobox.com>
Date: Thu, 01 Apr 2004 13:16:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata problems on Promise SX4000 controller
References: <406BE23F.3000802@gmx.net>
In-Reply-To: <406BE23F.3000802@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Hi,
> 
> I had problems getting my Promise SX4000 controller to run with libata.
> First, I noticed libata refused to drive it (no associated PCI id). After
> patching that (including the handler for the right chipset), a
> "modprobe sata_promise" hung for about 15 minutes while initializing the
> ECC RAM. It then recognized the one attached harddisk, but disk access was
> not really possible (I gave up after waiting for half an hour or so).
> Let me apologize for testing an older version of libata. At the time I had
> the problems, it was the newest available version. I enabled debugging and
> post the logs here in the hope that they might help supporting this
> controller in the future.
> 
> A note about the controller itself: It has 4 Parallel ATA ports and no
> Serial ATA ports. The controller sports the usual SoftRAID from Promise
> (0,1,0+1 and 5). The RAID5 seems to be a new feature. I do not care about
> the RAID (well, I do, I'm writing a dm configuration helper for it right
> now), but I would like to access the drive.

Well, the main problem is that you are trying to drive a PATA controller 
with a SATA driver :)

If you wanted to list this as a feature request on 
http://bugzilla.kernel.org/ that might be reasonable...

I have no idea how different the PATA controllers are from the SATA one 
I tested.  Although it does detect your device, I don't know what 
differences exist...

	Jeff




