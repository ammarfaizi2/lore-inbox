Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWIKNbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWIKNbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWIKNbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:31:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:435 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932334AbWIKNby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:31:54 -0400
Message-ID: <45056544.8070303@pobox.com>
Date: Mon, 11 Sep 2006 09:31:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix 2.6.18-rc6 IDE breakage, add missing ident needed
 for	current VIA boards
References: <1157982307.23085.140.camel@localhost.localdomain>
In-Reply-To: <1157982307.23085.140.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ok Linus this should do the trick and is tested on the chipsets I have.
> There are two patches here. The first reverses the broken PCI_DEVICE
> conversion back to the old format. The second adds a missing PCI ID so 
> you can actually boot 2.6.18 on 2 month old VIA motherboards (right now only
> 2.6.18-mm works).

Two totally separate issues should be two totally separate patches.

For the first:
* just add the missing zeroes.  No need to revert PCI_DEVICE() usage.

For the second:
* the sata_via PCI ID has been queued for 2.6.19 for quite a while.  I 
don't see a hugely pressing need for it to be in 2.6.18, but it's not a 
big deal to me.

	Jeff


