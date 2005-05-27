Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVE0I3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVE0I3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVE0I3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:29:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:222 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262043AbVE0I3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:29:05 -0400
Message-ID: <4296DA4B.6040303@pobox.com>
Date: Fri, 27 May 2005 04:28:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de>
In-Reply-To: <20050527074712.GQ1435@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 27 2005, Jeff Garzik wrote:
>>I just noticed a bug -- When ata_scsi_qc_new() fails, the code should 
>>complete the command with queue-full, but does not.
>>
>>        qc = ata_scsi_qc_new(ap, dev, cmd, done);
>>        if (!qc)
>>                return;
> 
> 
> Indeed, looks like an old bug.

Yep.  If you are knocking around in that area, would you mind killing it 
for me?  :)

	Jeff


