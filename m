Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVBZAAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVBZAAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVBZAAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:00:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34785 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262803AbVBZAAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:00:30 -0500
Message-ID: <421FBC0B.5070004@pobox.com>
Date: Fri, 25 Feb 2005 19:00:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Felix <gregfelixlkml@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH7 SATA support question for ATA_PIIX
References: <e16ac85e050225153649939bed@mail.gmail.com>
In-Reply-To: <e16ac85e050225153649939bed@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Felix wrote:
> I have two new OEM machines that are both ICH7 chipsets.  
> Both machines give the same vendor and device PCI ids for their
> storage controllers.
> 
> 8086:27df and 8086:27c0
> 
> I noticed that Jason Gaston submitted a patch that made it into
> 2.6.11-rc1 to add support for ICH7 into ata_piix.  I'm using
> 2.6.11-rc5 and am getting good results on one of my machines.
> 
> The problem I'm having is that the other machine doesn't seem to be
> supported even though it appears to be the same controller (by PCI ID
> at least).  My modules.pcimap file shows that x27df and x27c0 are both
> mapped to the piix driver.  I'm seeing nothing in /proc/partitions.
> 
> Perhaps someone at Intel, or HP, or Jason Gaston, or Jeff Garzik even
> can shed some light on this or tell me where I can look to determine a
> chipset version number that can be used to differentiate the two
> boxes?  I'll gladly provide any more information I've forgotten.

See REPORTING-BUGS for the sort of information you should provide.  This 
is a "it doesn't work" report without much more info.

I would suggest doing a "modprobe ata_piix" or "modprobe ahci" 
(depending on ICH7 mode and hardware) and see what happens in 'dmesg'.

	Jeff



