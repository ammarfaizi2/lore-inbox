Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274696AbRIYXJ2>; Tue, 25 Sep 2001 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274695AbRIYXJS>; Tue, 25 Sep 2001 19:09:18 -0400
Received: from mithra.wirex.com ([65.102.14.2]:56333 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S274692AbRIYXJH>;
	Tue, 25 Sep 2001 19:09:07 -0400
Message-ID: <3BB10E8E.10008@wirex.com>
Date: Tue, 25 Sep 2001 16:09:02 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
        Greg KH <greg@kroah.com>
Subject: Re: Binary only module overview
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>ever be permitted to be proprietary. Some feel that all LSM modules 
>>should be OSD-compliant Open Source software, while others feel that LSM 
>>should continue the existing Linux module policy of permitting 
>>proprietary modules only if they do not require changes to the Linux 
>>kernel (which would make them a derived work of the kernel).
>>
>With the current lunatic US congress proposals on security, crypto and
>building big brother into all PC's I'd say allowing non GPL security modules
>is positively dangerous to the well being of non US citizens
>
Alan made a very interesting point in this post back in June 
http://lwn.net/2001/0614/a/ac-modules.php3   that the Linux kernel is 
all fundamentally GPL licensed. Because the kernel is a composite work 
of many authors, and all that code was contributed under the GPL 2. It 
would require the unanimous consent of all the copyright holders to 
change the license.

That it is GPL licensed in turn has implications. One of them is that 
you are not allowed to impose additional constraints on distribution:

    * Clause 4: "You may not copy, modify, sublicense, or distribute the
      Program except as expressly provided under this License."
    * Clause 6: "... You may not impose any further restrictions on the
      recipients' exercise of the rights granted herein."

Therefore, any additional constraints people may wish to impose, such as 
Greg's comment in security.h, are invalid. When someone receives a copy 
of the Linux kernel, the license is pure, vanilla GPL, with no funny 
riders.*

The question of whether proprietary (non-GPL) modules are permitted is a 
matter of opinion. As Alan states in the June post above, Linus has 
given his opinion (that binary modules are ok, so long as it doesn't 
require kernel changes to run) but that is *only* Linus' opinion. Others 
may have different opinions, but they are all just opinions until the 
courts eventually rule on how the GPL is to be interpreted in this matter.

In light of all that, I propose that the LSM project take a strictly 
neutral stance on the question of binary modules. LSM imposes no new 
restrictions (which would be invalid anyway) and makes no judgment on 
whether binary modules are appropriate. As such, we would replace Greg's 
comment in security.h (and in all other LSM-specific files) with a 
comment that says "Copyright 2001 <authors>, Licensed under the GPL. See 
the Linux Kernels COPYING file for details."

How does that sound to folks?

Crispin

[*] The singular exception is the rider that Linus prepended to the 
Linux COPYING file, scoping what the GPL applies to. Presumably this 
rider was added before multiple authors got involved. If you wanna 
challenge Linus's exception and insist that all Linux applications are 
GPL'd, that's another thread :-)

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html



