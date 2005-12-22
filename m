Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVLVBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVLVBIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVLVBIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 20:08:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27577 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964998AbVLVBIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 20:08:31 -0500
Subject: Re: ATA Write Error and Time-out Notification in User Space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Drew Winstel <raw@dslr.net>
Cc: linux-ide@vger.kernel.org, John Treubig <jtreubig@hotmail.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200512201831.38592.raw@dslr.net>
References: <BAY101-F33B48301330A7FFF7849A4DF3E0@phx.gbl>
	 <1135119036.25010.21.camel@localhost.localdomain>
	 <200512201831.38592.raw@dslr.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Dec 2005 01:09:16 +0000
Message-Id: <1135213756.10383.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-20 at 18:31 -0600, Drew Winstel wrote:
> With the application that John is using (namely, it delivers reads and writes 
> directly to the drive via various SG ioctls), the file system is not an 
> issue, hence wanting the errors to be returned to userspace.  
> 
> I presume this means that John would have to look at the block level error 
> handling as opposed to the SCSI level?

If you are using the sg ioctls then the commands are dispatched and the
results come through the request queues but not the block layer above. 

In that case you really shouldn't be seeing a hang.

Alan

