Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVEDSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVEDSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVEDSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:00:15 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18576 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261244AbVEDR7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:59:16 -0400
Message-ID: <42790D80.6020300@tmr.com>
Date: Wed, 04 May 2005 13:59:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oskar Liljeblad <oskar@osk.mine.nu>
CC: Drew Winstel <DWinstel@Miltope.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
References: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local><66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local> <20050503172845.GA12944@oskar>
In-Reply-To: <20050503172845.GA12944@oskar>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oskar Liljeblad wrote:
> On Tuesday, May 03, 2005 at 11:53, Drew Winstel wrote:
> 
>>I think I know what the problem is.
>>
>>In include/linux/libata.h, make sure the preprocessor declarations are as 
>>follows.  I think the defaults have ATA_ENABLE_PATA undefined.
>>
>>#define ATA_ENABLE_ATAPI        /* undefine to disable ATAPI support */
>>#define ATA_ENABLE_PATA          /* define to enable PATA support in some
>>                                 * low-level drivers */
> 
> 
> Thanks, now it loads correctly. Unfortunately the clock drift still occurs
> with pata_pdc2027x. I'm guessing here, but can clock drift have anything
> to do with IRQs? Also, is it normal to see errors in /proc/interrupt?

Are you by chance running ntpd? And have you checked to see if it dies 
as soon as it starts? There's a bug in the ntp M/L wrt execstack.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
