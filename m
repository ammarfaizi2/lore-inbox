Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWITJ5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWITJ5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 05:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWITJ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 05:57:38 -0400
Received: from server6.greatnet.de ([83.133.96.26]:7828 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750908AbWITJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 05:57:37 -0400
Message-ID: <4511109E.4050103@nachtwindheim.de>
Date: Wed, 20 Sep 2006 11:57:50 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi-driver ultrastore replace Scsi_Cmnd with struct
 scsi_cmnd
References: <44FE8BAC.1030004@nachtwindheim.de> <20060918185321.GB17670@infradead.org>
In-Reply-To: <20060918185321.GB17670@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Wed, Sept 06, 2006 at 10:49:48AM +0200, Henne wrote:From: Henrik Kretzschmar <henne@nachtwindheim.de>
>>
>>Replaces the typedef'd Scsi_Cmnd with struct scsi_cmnd.
>>Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

>Looks good to me.  It would be even better if you could update the
>driver to not require
>
>	#include "scsi.h"
>
>anymore and get rid of ultrastor.h.  Also your mailer unfortunately
>damages tabs.

Sure, thats the big goal for all scsi drivers,but I decided to do one step after another.
I think it would be better to remove Scsi_Cmnd first to remove drivers/scsi/scsi_typedefs.h
first and then make the drivers use the headers in include/scsi/.
This is imho clearer to have one target per patch.
1. -	change Scsi_Cmnd to struct scsi_cmnd
	remove scsi_typedefs.h from drivers/scsi/scsi.h
	remove scsi_typedefs.h from the tree
2. -	put the local headers into c files if only used
	by the driver itself (maybe delete unneeded prototypes or reorder the functions that no prototypes are needed)
3. -	switch over to include/scsi/

Thats is my opinion.

>Also your mailer unfortunately damages tabs.

No, it doesn't. Even if it thunderbird. :)
ultrastor.h uses 4 spaces as intention and I just forgot to replace the with a tab.
Thanks. 
But I'm still looking for an easy standalone commandline smtp-engine to send my patches. Any suggestions?

Greets,
Henne



