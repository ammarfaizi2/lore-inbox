Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVK2Opd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVK2Opd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVK2Opd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:45:33 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:15484 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751363AbVK2Opc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:45:32 -0500
Message-ID: <438B906E.7070600@tmr.com>
Date: Mon, 28 Nov 2005 18:19:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: linux-kernel@vger.kernel.org, moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Use enum to declare errno values
References: <200511231631.12365.vda@ilport.com.ua> <XFMail.20051124104334.pochini@shiny.it>
In-Reply-To: <XFMail.20051124104334.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> On 23-Nov-2005 Denis Vlasenko wrote:
> 
>>On Wednesday 23 November 2005 15:24, moreau francis wrote:
>>
>>>Hi,
>>> 
>>>I'm just wondering why not declaring errno values using enumaration ? It is 
>>>just more convenient when debuging the kernel.
>>
>>Enums are really nice substitute for integer constants instead of #defines.
>>Enums obey scope rules, #defines do not.
>>
>>However enums are not widely used because of
>>1. tradition and style
>>2. awkward syntax required:   enum { ABC = 123 };
> 
> 
> The value of an enum constant must be representable as an int. This
> is not always the case, expecially with hardware constants and bit
> masks, which may require an unsigned int.

Could you provide an example of where the ERRNO is not an integer? It 
doesn't take on bit values, nor can I spot a plcae where the value is so 
large it would overflow if signed.

See errno.h for a starting point. I do think error_t is a good idea, 
although I doubt there's an example of a type mismatch going uncaught 
without it.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

