Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbUCZBEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUCZAbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:31:47 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:25104 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263860AbUCZALN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:11:13 -0500
Date: Thu, 25 Mar 2004 17:10:24 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <1048370000.1080259823@aslan.btc.adaptec.com>
In-Reply-To: <406372C5.600@pobox.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <40632994.7080504@pobox.com> <1035780000.1080258411@aslan.btc.adaptec.com> <406372C5.600@pobox.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> None of the solutions being talked about perform "failing over" in
>> userland.  The RAID transforms which perform this operation are kernel
>> resident in DM, MD, and EMD.  Perhaps you are talking about spare
>> activation and rebuild?
> 
> This is precisely why I sent the second email, and made the qualification
> I did :)
> 
> For a "do it in userland" solution, an initrd or initramfs piece examines
> the system configuration, and assembles physical disks into RAID arrays
> based on the information it finds.  I was mainly implying that an initrd
> solution would have to provide some primitive failover initially, before
> the kernel is bootstrapped...  much like a bootloader that supports booting
> off a RAID1 array would need to do.

"Failover" (i.e. redirecting a read to a viable member) will not occur
via userland at all.  The initrd solution just has to present all available
members to the kernel interface performing the RAID transform.  There
is no need for "special failover handling" during bootstrap in either
case.

--
Justin

