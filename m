Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUCYSub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbUCYSuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:50:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38082 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263561AbUCYStG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:49:06 -0500
Message-ID: <40632994.7080504@pobox.com>
Date: Thu, 25 Mar 2004 13:48:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Kevin Corry <kevcorry@us.ibm.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com>
In-Reply-To: <40632804.1020101@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> My take on things...  the configuration of RAID arrays got a lot more 
> complex with DDF and "host RAID" in general.  Association of RAID arrays 
> based on specific hardware controllers.  Silently building RAID0+1 
> stacked arrays out of non-RAID block devices the kernel presents. 
> Failing over when one of the drives the kernel presents does not respond.
> 
> All that just screams "do it in userland".

Just so there is no confusion...  the "failing over...in userland" thing 
I mention is _only_ during discovery of the root disk.

Similar code would need to go into the bootloader, for controllers that 
do not present the entire RAID array as a faked BIOS INT drive.

	Jeff



