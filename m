Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270797AbRIAQ17>; Sat, 1 Sep 2001 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270800AbRIAQ1t>; Sat, 1 Sep 2001 12:27:49 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:7560 "EHLO
	localhost.digitalaudioresources.org") by vger.kernel.org with ESMTP
	id <S270797AbRIAQ1i>; Sat, 1 Sep 2001 12:27:38 -0400
Message-ID: <3B910C74.5030407@digitalaudioresources.org>
Date: Sat, 01 Sep 2001 09:27:32 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jim Roland <jroland@roland.net>, Jan Niehusmann <jan@gondor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <E15dD2V-0005ER-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I'm on 2.4.9.  No overclocking.  I applied the patch that somebody (sorry, 
>>forgot who) posted yesterday for arch/i386/lib/mmx.c and rebuilt the kernel with 
>>Athlon optimization.  It now works.
>>
> 
> Well not really. The patch posted turns off athlon optimisation even though
> you selected it

Well, that's what I thought, too, since that was the only file in the kernel 
source where CONFIG_MK7 was defined.  Somebody pointed out to me, though, that 
there are other defines that are turned on if you use Athlon settings, like 
(from arch/i386/config.in):

CONFIG_X86_GOOD_APIC
CONFIG_X86_USE_3DNOW
CONFIG_X86_PGE

Although, looking at arch/i386/config.in again right now, I see none of these 
are Athlon specific.  That's what I get for trusting somebody else instead of 
looking into it myself.

Thanks.
-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

