Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVCDBve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVCDBve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVCDBr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:47:58 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:19943 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262729AbVCDBpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:45:23 -0500
Date: Fri, 4 Mar 2005 12:44:16 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE locking (was: Re: RFD: Kernel release numbering)
Message-ID: <20050304014415.GG30616@zip.com.au>
References: <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <42274171.3030702@nortel.com> <20050303165940.GA11144@kroah.com> <1109893901.21780.68.camel@localhost.localdomain> <20050304001930.GF30616@zip.com.au> <1109897041.21781.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109897041.21781.75.camel@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:44:04AM +0000, Alan Cox wrote:
> On Gwe, 2005-03-04 at 00:19, CaT wrote:
> > Working IDE locking? Does this mean if I have 2 promise cards, a HD
> > on each card and I copy from one to the other it wont all blow up in my
> > face?
> 
> Depends on your PCI bus and also if the are on the same IRQ. In the same

Hmm. How can I check on this? What should I look for?

> IRQ case you may find 2.6.11 is a bit saner as Bartlomiej may have
> sorted one of the IRQ masking problems now.

/proc/interrupts reports different irqs for each ide device:

  5:    5018683          XT-PIC  ide4
 11:     167995          XT-PIC  ide2, eth0
 14:      39799          XT-PIC  ide0
 15:      10704          XT-PIC  ide1

The problems were weird. The fs I was copying from decided it was
corrupt. Unmounting the partition and trying an fsck reported that it
couldn't find the partition. After a reboot all was well and a fsck
reported no problems.

-- 
    Red herrings strewn hither and yon.
