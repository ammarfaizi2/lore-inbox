Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269471AbUJFVYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269471AbUJFVYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269507AbUJFUqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:46:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31941 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269501AbUJFUpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:45:12 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Patrick Gefre <pfg@sgi.com>
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Wed, 6 Oct 2004 13:44:38 -0700
User-Agent: KMail/1.7
Cc: Grant Grundler <iod00d@hp.com>, Colin Ngam <cngam@sgi.com>,
       "Luck, Tony" <tony.luck@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <20041006195424.GF25773@cup.hp.com> <41645150.6020608@sgi.com>
In-Reply-To: <41645150.6020608@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410061344.38265.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 6, 2004 1:10 pm, Patrick Gefre wrote:
> I don't plan on respinning the large patches (unless of course they get out
> of date). It would be great to get the kill, add and qla patch in so we can
> move forward and address some these other smaller issues - rather than
> holding up the larger mods for them.

I agree, but could you please just 'vi' the 002-add-files patch and remove 
these?

 drivers/char/mmtimer.c                          |    1
 drivers/char/snsc.c                             |   25
 drivers/ide/pci/sgiioc4.c                       |   23
 drivers/serial/sn_console.c                     |  214

They should each be separate cleanup patches.  What I've done in the past is 
make copies (in this case 5) of the big patch.  Then I edit all of them to 
include only the hunks I want there.  Hopefully that'll minimize the pain of 
respinning the big patch (i.e. no respin).  Also, Tony doesn't want to deal 
with the above files, patches for them should be sent to Andrew as separate 
mails with lkml in the cc list.

Other than that, I'm all for getting these into the tree.  Thanks for all the 
work you've put into this!

Thanks,
Jesse
