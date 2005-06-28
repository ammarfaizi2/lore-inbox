Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVF1DbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVF1DbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVF1DbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:31:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31444 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262339AbVF1DbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:31:10 -0400
Message-ID: <42C0C478.5040903@pobox.com>
Date: Mon, 27 Jun 2005 23:31:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cfq build breakage
References: <42C0B39E.7070509@pobox.com> <20050627201333.4c7d3d06.akpm@osdl.org>
In-Reply-To: <20050627201333.4c7d3d06.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>
>>In latest git tree...
>>
>>   CC [M]  drivers/block/cfq-iosched.o
>>drivers/block/cfq-iosched.c: In function `cfq_put_queue':
>>drivers/block/cfq-iosched.c:303: sorry, unimplemented: inlining failed 
>>in call to 'cfq_pending_requests': function body not available
>>drivers/block/cfq-iosched.c:1080: sorry, unimplemented: called from here
>>drivers/block/cfq-iosched.c: In function `__cfq_may_queue':
>>drivers/block/cfq-iosched.c:1955: warning: the address of 
>>`cfq_cfqq_must_alloc_slice', will always evaluate as `true'
>>make[2]: *** [drivers/block/cfq-iosched.o] Error 1
>>make[1]: *** [drivers/block] Error 2
>>make: *** [drivers] Error 2
> 
> 
> hm.  The inline thing is trivial, but the misuse of
> cfq_cfqq_must_alloc_slice() means that we now wander into untested
> territory.
> 
>  drivers/block/cfq-iosched.c |   49 +++++++++++++++++++++-----------------------
>  1 files changed, 24 insertions(+), 25 deletions(-)

FWIW I just removed the 'inline' marker, which caused a lot less 
fallout.  Jens or Nick or whomever can do a better fix later :)

	Jeff



