Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUJYXyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUJYXyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbUJYWXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:23:25 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6034 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261974AbUJYWTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:19:55 -0400
Message-ID: <417D7C9D.8040409@tmr.com>
Date: Mon, 25 Oct 2004 18:22:21 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Risolia <luca.risolia@studio.unibo.it>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, luc@saillard.org
Subject: Re: Linux 2.6.9-ac3
References: <417A70A1.4040101@tmr.com><20041022101335.6dcf247a.luca.risolia@studio.unibo.it> <20041023193651.1cbcb80d.luca.risolia@studio.unibo.it>
In-Reply-To: <20041023193651.1cbcb80d.luca.risolia@studio.unibo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Risolia wrote:
> On Sat, 23 Oct 2004 10:54:25 -0400
> Bill Davidsen <davidsen@tmr.com> wrote:
> 
> 
>>Luca Risolia wrote:
>>
>>>>o       Restore PWC driver                              (Luc Saillard)
>>>
>>>
>>>This driver does decompression in kernel space, which is not
>>>allowed. That part has to be removed from the driver before
>>>asking for the inclusion in the mainline kernel.
>>
>>What do you mean by "not allowed?"
> 
> 
> http://marc.theaimsgroup.com/?l=linux-video&m=108627734619978&w=2
> 
> Also note how Alan Cox seems not to be actually coherent with his
> previous opinions.

If you're a Republican he's "wishy-washy", if you're a Democrat he's 
"flexible and adaptable to changing conditions." If you're not a US 
resident you're confused by the previous sentence, please ignore it's an 
in-joke (or tragedy).
> 
>  Clearly it would nice if it were in 
> 
>>user space, but it would have to be in EVERY user application to be 
>>useful. We have compression in kernel for ppp, and there's only one 
>>significant use for that, requiring that every application support every 
>>vendor hardware makes it a non-scalable NxM problem.
> 
> 
> Hmm..What about a common library finally?

That sounds like the eventual solution. A vendor to common format 
conversion library, and with luck someone will be clever and let the 
driver select it in a nice acceptable way. Thought: after open an ioctl 
to tell you which conversion to use? The optimal mechanics are 
inobvious, but I think the library is the right idea.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
