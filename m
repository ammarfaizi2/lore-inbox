Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVFFUTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVFFUTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVFFUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:19:05 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:19129 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261658AbVFFURh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:17:37 -0400
Message-ID: <42A4B328.1010400@freemail.hu>
Date: Mon, 06 Jun 2005 22:33:44 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
References: <42A2A0B2.7020003@freemail.hu>	<42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <42A2BC4B.5060605@freemail.hu> <42A2CF27.8000806@freemail.hu> <42A3176F.9030307@freemail.hu>
In-Reply-To: <42A3176F.9030307@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Zoltan Boszormenyi írta:
> Zoltan Boszormenyi írta:
> 
>> I will try some older kernels, too.
> 
> 
> OK, I tried 2.6.12-rc5, -rc4, -rc3, -rc2, same problem.
> Strangest thing is, after gpm starts, I can use the USB mice
> on the console. When X starts, the mice die. DRI bug?
> I will try even earlier kernels, too.

I haven't disappeared, between family and workday I compiled
and booted some earlier kernels. Final result: kernels down to
2.6.11-bk7 do not work, 2.6.11-bk6 and -bk5 work.
All the -bk7+ kernels I tried produced the same strange bug
on my system: after gpm started I was able to move the
pointer on the screen but when X started up, it's pointer froze.

Please, forget what I said about -mmX kernels, I remember
that I updated the multiconsole patch to certain kernel versions
and I tested them for clean compilation but I may not have
actually booted them.

Another difference between 2.6.11-bk5/6 and -bk7+:
Kudzu complains about a missing PS/2 keyboard and indeed,
the kernel does not recognize the keyboard on the AUX port
on -bk5/6, -bk7 and later recognize it again.

Best regards,
Zoltán Böszörményi
