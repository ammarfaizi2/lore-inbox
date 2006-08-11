Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWHKW12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWHKW12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWHKW12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:27:28 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:5853 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751088AbWHKW11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:27:27 -0400
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <1155334308.7574.50.camel@localhost.localdomain>
References: <1155334308.7574.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 17:27:17 -0500
Message-Id: <1155335237.3552.48.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 15:11 -0700, Dave Hansen wrote:
> My scsi card stopped being detected in 2.6.18-rc3-mm2, but works in
> plain 2.6.18-rc3.  I bisected all the way down to the git-sas.patch.
> I
> then noticed that if I enable the AIC94XX driver, my card works again.
> 
> I'm digging through it right now, but I figured I'd post in case
> anyone
> else had seen this.  This error mode seems vaguely familiar as well.
> Any ideas?

There's nothing in the driver diff that interferes with the aic7xxx ...
my best guess would be some cockup over duplicate pci id claims ...
what's the lspci -n output for the card?

James


