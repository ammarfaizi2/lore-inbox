Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbULJW7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbULJW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULJW7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:59:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:24452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261856AbULJW7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:59:10 -0500
Message-ID: <41BA2948.4030906@osdl.org>
Date: Fri, 10 Dec 2004 14:55:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI -rc fixes for 2.6.10-rc3
References: <1102650988.3814.13.camel@mulgrave> <20041210201115.GD12581@suse.de>
In-Reply-To: <20041210201115.GD12581@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Dec 09 2004, James Bottomley wrote:
> 
>>This one is another set of small driver fixes
>>
>>It is available from:
> 
> 
> Here is one more. Currently imm uses page_address() which can crash on
> highmem. It's not directly doable to map the pages properly, at least
> not without changing some code. In lack of a ->bounce_highio member in
> the scsi host template, just set ->unchecked_isa_dma which will just
> bounce everything for us. imm isn't performance critical by any stretch
> of the imagination, so...
> 
> Usually I'd not encourage such a silly hack, but in lack of hardware for
> testing (who has it??), this should suffice as it is obviously correct.

I have a drive, but I'm not near a highmem machine atm.
I can test it next week if no one else does so.

-- 
~Randy
