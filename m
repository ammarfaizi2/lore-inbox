Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUHUPBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUHUPBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 11:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUHUPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 11:01:15 -0400
Received: from mail5.ewetel.de ([212.6.122.32]:25508 "EHLO mail5.ewetel.de")
	by vger.kernel.org with ESMTP id S266481AbUHUPBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 11:01:12 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <2vDtS-bq-19@gated-at.bofh.it>
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
Date: Sat, 21 Aug 2004 17:01:03 +0200
Message-Id: <E1ByXMd-00007M-4A@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 14:50:08 +0200, you wrote in linux.kernel:

> If the owners and permissions of the filesystem have been set up correctly,
> then there is no security problem. 

The previous Linux implementation allowed users with *read* access
to the device to send arbitrary SG_IO commands. Giving read permission
to normal users is quite common, to allow them to run isosize or play
their freshly burned SVCDs with mplayer.

It violated the principle of least surprise that a user can screw
the device without even having write permission.

Yes, it breaks user-space programs, and yes, the kernel is to blame
for its previous behavior, not user-space. However, now we need to
get on, and going back to the previous behavior, which because
the discussion is now a well-known security hole, is not an option.

-- 
Ciao,
Pascal
