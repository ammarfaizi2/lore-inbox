Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVBWVTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVBWVTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVBWVTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:19:07 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:9431 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261593AbVBWVOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:14:38 -0500
Message-ID: <421CF352.2090200@tmr.com>
Date: Wed, 23 Feb 2005 16:19:14 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
References: <20050220155600.GD5049@vanheusden.com><20050220155600.GD5049@vanheusden.com> <20050220164010.GA17806@ime.usp.br>
In-Reply-To: <20050220164010.GA17806@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> On Feb 20 2005, Folkert van Heusden wrote:
> 
>>My linux laptop says:
>>irq 5: nobody cared!
> 
> (...)
> 
>>Does anyone care? :-)
> 
> 
> Well, I'm getting similar stack traces with my system and those are sure
> scary, but it seems that my e-mails to the list are simply ignored,
> unfortunately.

I posted a similar thing, but the problem is not that you get the 
message. It means your hardware generated an unexpected interrupt. The 
kernel is reporting that fact as it should.

The problem I had (not resolved) is that after the message
   DISABLING IRQ NN
I continued to get interrupts! So the logic to disable the IRQ is not 
working correctly.

as you note, because the hardware is generating the condition, no one 
seems to care, even though there clearly is a problem in the disable 
logic. I found a way to fix my hardware thanks to some pointers I got, 
so I'm running, but I haven't heard that the base problem is fixed.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
