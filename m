Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265539AbUFONwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUFONwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUFONwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:52:05 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33945 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265539AbUFONwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:52:02 -0400
Message-ID: <40CEFF1E.70201@tmr.com>
Date: Tue, 15 Jun 2004 09:52:30 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: NUMA API observations
References: <271SM-3DT-7@gated-at.bofh.it> <272lY-44B-49@gated-at.bofh.it> <2772a-7VK-9@gated-at.bofh.it> <279nf-1id-3@gated-at.bofh.it>
In-Reply-To: <279nf-1id-3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Jun 14, 2004 at 02:21:28PM -0700, Paul Jackson wrote:
> 
>>Andi wrote:
>>
>>>How should a user space application sanely discover the cpumask_t
>>>size needed by the kernel?  Whoever designed that was on crack.
>>>
>>>I will probably make it loop and double the buffer until EINVAL
>>>ends or it passes a page and add a nasty comment.
>>
>>I agree that a loop is needed.  And yes someone didn't do a very
>>good job of designing this interface.
> 
> 
> I add some code to go upto a page now.
> 
> This adds a hardcoded limit of 32768 CPUs to libnuma. That's not 
> nice, but we have to stop somewhere in case the EINVAL is returned
> for other reason

Should be enough for desktop machines...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
