Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWJFTP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWJFTP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWJFTP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:15:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5800 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932450AbWJFTP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:15:26 -0400
Message-ID: <4526AB43.7030809@garzik.org>
Date: Fri, 06 Oct 2006 15:15:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
References: <1160161519800-git-send-email-matthew@wil.cx> <11601615192857-git-send-email-matthew@wil.cx>
In-Reply-To: <11601615192857-git-send-email-matthew@wil.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Also, pci_set_mwi() will fail if the cache line
> size is 0, so we don't need to check that ourselves any more.

NAK, not true on all arches.  sparc64 at least presumes that the 
firmware DTRT with cacheline size, which hurts us now given this tulip patch

	Jeff


