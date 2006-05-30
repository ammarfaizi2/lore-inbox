Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWE3NWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWE3NWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWE3NWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:22:35 -0400
Received: from rtr.ca ([64.26.128.89]:45233 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751400AbWE3NWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:22:34 -0400
Message-ID: <447C4718.6090802@rtr.ca>
Date: Tue, 30 May 2006 09:22:32 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patch] libata resume fix
References: <20060528203419.GA15087@havoc.gtf.org> <1148938482.5959.27.camel@localhost.localdomain>
In-Reply-To: <1148938482.5959.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Sun, 2006-05-28 at 16:34 -0400, Jeff Garzik wrote:
>> Please pull from 'upstream-fixes' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> to receive the following updates:
>>
>>  drivers/scsi/libata-core.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> Mark Lord:
>>       the latest consensus libata resume fix
> 
> If your devices are coming from poweron-reset then you will have to wait
> up to 31 seconds :( And yes, I _did_ have such a device at one point.

Not in a suspend/resume capable notebook, though.

I don't know of *any* notebook drives that take longer
than perhaps five seconds to spin-up and accept commands.
Such a slow drive wouldn't really be tolerated by end-users,
which is why they don't exist.

But I suppose people will want to suspend/resume bigger machines
too, in which case a 10000rpm Raptor might need 15 seconds or so.

We could bump up the existing timeout, I suppose.

Perhaps Jeff could comment on any potential harm in libata
for going all the way to 3100000 with the timeout?

Cheers
