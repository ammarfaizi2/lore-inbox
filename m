Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWHWPmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWHWPmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWHWPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:42:24 -0400
Received: from 81-179-62-49.dsl.pipex.com ([81.179.62.49]:54421 "EHLO
	jaguar.linux-grotto.org.uk") by vger.kernel.org with ESMTP
	id S964977AbWHWPmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:42:23 -0400
Message-ID: <44EC775C.7040003@linux-grotto.org.uk>
Date: Wed, 23 Aug 2006 16:42:20 +0100
From: Johan Groth <johan.groth@linux-grotto.org.uk>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca>
In-Reply-To: <44EC73D2.9090302@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Johan Groth wrote:

[snip]

> Basically, given an I/O request for 200 sectors, with a bad sector
> in the middle at number 100, what SCSI will often do is fail sectors
> number 1 through 100, one at a time, retrying the entire remainder of
> the request after each attempt.  This takes hours, and results in no
> data for the first 99 good sectors.

So what you are saying is that after the move to a new box and a new 
mobo a sector has gone bad on that raid slice? Weird, as I was very 
careful this those drives when I moved them.

I mean, the raid controller is the same, the cpus are the same, just 
more of them, the pci-x bus the same so I didn't expect any problems at 
all.

I was also under the impression that SATA raid controllers work like 
SCSI raid controllers in the way that if a bad sector is encountered the 
controller moves what it can and the mark the sector as bad. I might be 
very wrong about that, though.

However, if I have a bad sector I would like to have that one marked as 
bad so the kernel never tries to read it again. Any suggestions how I do 
that. I assume I have to boot something like Knoppix as sda is my system 
disk.

Regards,
Johan

