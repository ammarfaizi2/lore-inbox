Return-Path: <linux-kernel-owner+w=401wt.eu-S936532AbWLIJXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936532AbWLIJXB (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936581AbWLIJXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:23:01 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59298 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936532AbWLIJXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:23:00 -0500
Message-ID: <457A806F.5000508@garzik.org>
Date: Sat, 09 Dec 2006 04:22:55 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       koan <koan00@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at drivers/scsi/ahci.c:859/ahci_host_intr() [ 2.6.17.14
 ]
References: <64d833020612081705p29c92e85i25f045ad87cb879e@mail.gmail.com> <20061209011830.14d99a20@localhost.localdomain> <20061209013332.GA15222@dspnet.fr.eu.org>
In-Reply-To: <20061209013332.GA15222@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Sat, Dec 09, 2006 at 01:18:30AM +0000, Alan wrote:
>> On Fri, 8 Dec 2006 20:05:07 -0500
>> koan <koan00@gmail.com> wrote:
>>
>>> ata4: status=0x50 { DriveReady SeekComplete }
>>> ata4: error=0x01 { AddrMarkNotFound }
>> That looks like a genuine drive problem.
> 
> Is a disk driver supposed to BUG() on a drive missing sector though?

No, which is why the upstream driver doesn't contain any BUG_ON() or 
WARN_ON() calls anymore...  Usually those messages signal incomplete 
areas of the driver.


	Jeff



