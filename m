Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWARRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWARRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWARRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:33:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1446 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751407AbWARRdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:33:07 -0500
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43CE6997.6090005@rtr.ca>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
	 <43CE1E52.3030907@aitel.hist.no>  <43CE6997.6090005@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 17:32:20 +0000
Message-Id: <1137605541.29681.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 11:15 -0500, Mark Lord wrote:
> For example, one bad sector on a drive doesn't mean that
> the entire drive has failed.  It just means that one 512-byte
> chunk of the drive has failed.

You don't actually know what failed, truth be told, probably a lot more
than 512 byte spec of disk nowdays.

> We could rewrite the failed area of the drive, allowing the
> onboard firmware to repair the fault internally, likely by

We should do so definitely but you probably want to rewrite the stripe
as a whole so that you fix up the other sectors in the physical sector
that went poof.

> Just need somebody motivated to actually fix it,
> rather than bitch about how impossible/stupid it would be.

Send patches ;)

PS: How is the delkin_cb driver - does it know how to do modes and stuff
yet ? Just wondering if I should pull a version for libata whacking

Alan
