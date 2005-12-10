Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVLJAX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVLJAX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVLJAX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:23:58 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:17044 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S932527AbVLJAX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:23:58 -0500
Message-ID: <439A201D.7030103@mnsu.edu>
Date: Fri, 09 Dec 2005 18:23:57 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
References: <1134154208.14363.8.camel@mindpipe>  <439A0746.80208@mnsu.edu> <1134173138.18432.41.camel@mindpipe>
In-Reply-To: <1134173138.18432.41.camel@mindpipe>
Content-Type: multipart/mixed;
 boundary="------------080108020708040404030303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080108020708040404030303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:

>On Fri, 2005-12-09 at 16:37 -0600, Jeffrey Hundstad wrote:
>  
>
>>Lee Revell wrote:
>>
>>    
>>
>>>I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
>>>I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
>>>with:
>>>
>>>$ make ARCH=x86_64
>>> [...]
>>> CC      init/initramfs.o
>>>
>>>
>>>      
>>>
>>I have successfully done this using Debian/Sid.
>>
>>    
>>
>
>I added "-m64" to AFLAGS as well and now I get farther:
>
>  CC      arch/x86_64/ia32/syscall32.o
>  AS      arch/x86_64/ia32/vsyscall-sysenter.o
>arch/x86_64/ia32/vsyscall-sysenter.S: Assembler messages:
>arch/x86_64/ia32/vsyscall-sysenter.S:14: Error: suffix or operands invalid for `push'
>arch/x86_64/ia32/vsyscall-sysenter.S:16: Error: suffix or operands invalid for `push'
>arch/x86_64/ia32/vsyscall-sysenter.S:18: Error: suffix or operands invalid for `push'
>arch/x86_64/ia32/vsyscall-sysenter.S:25: Error: suffix or operands invalid for `pop'
>arch/x86_64/ia32/vsyscall-sysenter.S:27: Error: suffix or operands invalid for `pop'
>arch/x86_64/ia32/vsyscall-sysenter.S:29: Error: suffix or operands invalid for `pop'
>arch/x86_64/ia32/vsyscall-sigreturn.S:16: Error: suffix or operands invalid for `pop'
>make[1]: *** [arch/x86_64/ia32/vsyscall-sysenter.o] Error 1
>make: *** [arch/x86_64/ia32] Error 2
>
>Lee
>
>  
>

Yes, some commands NEED the -m64 and and WILL NOT work with -m64.

Really, try my method.  I've done it without all that making a separate 
binutils non-sense.
You do need the 64-bit Debian build tools and 64 bit libraries.  These 
are the ones I have:

amd64-libs
amd64-libs-dev
lib64gcc1
lib64gfortran0
lib64ncurses5
lib64ncurses5-dev
lib64objc1
lib64stdc++6
lib64stdc++6-4.0-dbg
lib64z1
lib64z1-dev
libc6-amd64
libc6-dev-amd64


Yes... here's lin64.tar.gz if you didn't catch my little scripts before.
BTW: if there's a better way, please let me know.  ...After I got this 
to work I kinda quit looking ;-)

-- 
Jeffrey Hundstad


--------------080108020708040404030303
Content-Type: application/gzip;
 name="lin64.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lin64.tar.gz"

H4sICP0emkMCA2xpbjY0LnRhcgDtmM9Og0AQh/cqTzGuvW667D9MTJO+hzGWUlpogDalTTDx
4V1QqwejHuya6u+7bJaZE7PfzkBVNs6M2UmRnsTafo0TK9+vr7BYau1UIp1WTMbS+TBZFoBD
u093RGytV4f6k7yv4mdKNdS/u3b3nTPC7w6dqBaB66+Sof4ydlpa4+uvjXGMJOp/cq4ux/Oy
Gc/TtoiqBYnaGRpNIwb+Bx/5n+5C+6+O/sd9Hvz/Ff/9e4D68F+ssiyo/7GNj/OfVLr330kF
/0P7HxVpq9VklmfFhvhoyumRVrt8S0IQF7VWfBaVS7r1sSGT04Q4pzu6oX2RN9GFPzjHCSKv
2vz5id8sS1wr5+N/88Pn/Lv9v/ffWjX0f2fgf2j/mxr9H/53YjNfZ5vtQ/Dv/7f/P8b6MQD+
B/b/pe64BAAAAAAAAAAAAAAA+CM8AZGQWWEAKAAA
--------------080108020708040404030303--
