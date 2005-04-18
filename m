Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVDRHce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVDRHce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVDRHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:32:34 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:45810 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261822AbVDRHc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:32:29 -0400
Message-ID: <42636285.9060405@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 16:32:21 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org>
In-Reply-To: <20050418061221.GA32315@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For example, please think about telephone switching software.
The software does not allow to stops over 100 milliseconds at worst
case.(this depends on how many customers are using, the more customers
are using, the allowable stopping time goes to shorter.)
And the system is required over 99.999% availability, so typically, the
system is constructed as ACT-SBY high-availability clustering model.
In the case of critical error the system takeover the service process to
SBY node.
Not to descent the service availability, software fix due to bug, should
not stop the service, and live patching is very historical function in
telecoms world.
Every carrier, NEPs(Network Equipment Provider) provide/use this
function to keep network service(such as telephone) available.
This function is very essential whenever the carrier use the linux as
center of it's system.

Therefore the live patching function should not stop the target
process(service process) as possible as. the more times we stop the
target process, the service goes unavailable...


Chris Wedgwood wrote:

>On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
>
>  
>
>>From our experience, sometimes patches became to dozens to hundreds
>>at one patching, and in this case GDB based approach cause target
>>process's availability descent.
>>    
>>
>
>i don't really buy that it can't be done or you complex patches are
>necessary to be honest --- and there are various alternative APIs that
>could help as others have pointed out
>
>
>could you perhaps explain some *real* *world* applications/systems
>where this is necessary and why existing APIs won't work with them
>perhaps?
>
>solving a real-world problem is much more interesting to listen to
>that filling in a check-box on a (somewhat dubious) specification
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


