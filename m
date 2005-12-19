Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVLST64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVLST64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVLST64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:58:56 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:27898 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964931AbVLST6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:58:55 -0500
Date: Mon, 19 Dec 2005 14:58:39 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
In-reply-to: <20051219193508.GL3734@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <1135022319.2029.11.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051219153236.GA10905@swissdisk.com>
 <20051219193508.GL3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 20:35 +0100, Jens Axboe wrote:
> On Mon, Dec 19 2005, Ben Collins wrote:
> > This patch fixes the WRITE vs READ issue, and also sends the extra two
> > commands. Anyone with an iPod connected via USB (not sure about firewire)
> > should be able to reproduce this issue, and verify the patch.
> 
> The bug was in the SCSI layer, and James already has the fix integrated
> for that. It really should make 2.6.15, James are you sending it upwards
> for that?

You mean this patch?

James Bottomley:
      [SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)

This fixes an oops with data direction because sbp2 was not checking
enough itself.

I seriously doubt this will fix the issue being reported. Changing the
blk request to a READ did not fix the problem. The problem was only
fixed by sending the extra two commands. The direction was just a side
issue.

Is there a problem with sending the commands? If they don't bother
unaffected devices, but it does fix a large number of other devices,
what's the problem?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

