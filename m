Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVEAJA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVEAJA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 05:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEAJA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 05:00:56 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:27702 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261566AbVEAJAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 05:00:49 -0400
Message-ID: <42749AF2.3010107@danbbs.dk>
Date: Sun, 01 May 2005 11:01:38 +0200
From: Mogens Valentin <monz@danbbs.dk>
Reply-To: monz@danbbs.dk
Organization: Mr Dev
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bryan Henderson <hbryan@us.ibm.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       aia21@hermes.cam.ac.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, mike.miller@hp.com
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
References: <OF48BA3721.BD4798AD-ON88256FF2.00680E7E-88256FF2.0069814F@us.ibm.com> <1114812035.18330.396.camel@localhost.localdomain>
In-Reply-To: <1114812035.18330.396.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The next question is what the I/O device does with the data. SCSI disks
> will cache but the scsi layer uses tags and if neccessary turns the
> cache off on the drive. In other words you should get that behaviour
> correctly on SCSI media.
> 
> The default IDE behaviour doesn't turn write cache off and the IDE
> device may re-order writes and ack them before they hit storage. IDE
> lacks tags, and tends to have poor performance on cache flush commands.
> With the barrier support on the right thing should occur, or with hdparm
> used to turn the write cache off.

Is this IDE behaviour confined to IDE drives only?
SATA, when using libata, will solemnly be part of the SCSI chain, and 
hense not subject to your mentioned write cache problem, right?

-- 
Kind regards,
Mogens Valentin

