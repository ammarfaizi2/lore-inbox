Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVKRAId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVKRAId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVKRAId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:08:33 -0500
Received: from rtr.ca ([64.26.128.89]:60812 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965169AbVKRAIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:08:32 -0500
Message-ID: <437D1B81.7000402@rtr.ca>
Date: Thu, 17 Nov 2005 19:08:33 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATA Raid needs a long time to recover from suspend
References: <437AA996.9080505@cfl.rr.com> <20051116170642.313aeada.akpm@osdl.org> <437BFF4A.4060402@cfl.rr.com>
In-Reply-To: <437BFF4A.4060402@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Andrew Morton wrote:
> 
>> This change will increase the minimum delay in both ata_wait_idle() and
>> ata_busy_wait() from 10 usec to 100 usec, which is not a good change.
>>
>> It would be less damaging to increase the delay in ata_wait_idle() from
>> 1000 to 100,000.  A one second spin is a bit sad, but the hardware's 
>> bust,

I wonder if this the same problem that prevents resume-from-ram
from working on my system when I use an older hard drive,
rather than the newer model that came installed (notebook)..

Whenever resume fails, the hard drive light is on solid
and the system is unresponsive.  And the backlight is off so no
debug info available (no serial ports, either).

Could be.. could be.

Cheers
