Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTEZRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTEZRq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:46:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261919AbTEZRqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:46:25 -0400
Message-ID: <3ED255FE.10609@pobox.com>
Date: Mon, 26 May 2003 13:59:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <3ED1B261.8030708@pobox.com> <Pine.LNX.4.44.0305260956590.11328-100000@home.transmeta.com> <20030526172405.GJ845@suse.de>
In-Reply-To: <20030526172405.GJ845@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, May 26 2003, Linus Torvalds wrote:
> 
>>>What does the block layer need, that it doesn't have now?
>>
>>Exactly. I'd _love_ for people to really think about this.
> 
> 
> In discussion with Jeff, it seems most of what he wants is already
> there. He just doesn't know it yet :-)


Another important point is time.

I continue to agree that a native block driver is the best direction.

But with 2.6.0 looming, I think it's best to evolve my ATA driver to be 
a native block driver from a scsi one.   Not start out as a native 
driver.  That's significant pre-2.6 churn.

Or, it lives out-of-tree until 2.7 and people with SATA hardware have to 
go out-of-tree for their driver for months and months, until the working 
driver is deemed sufficiently native :)  In the meantime, distros 
wanting working SATA will just ship the SCSI driver as-is.  :(

	Jeff



