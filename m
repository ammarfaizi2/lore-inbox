Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318784AbSICPFP>; Tue, 3 Sep 2002 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSICPFO>; Tue, 3 Sep 2002 11:05:14 -0400
Received: from pop.sttl.uswest.net ([206.81.192.7]:50698 "HELO
	sttlpop6.sttl.uswest.net") by vger.kernel.org with SMTP
	id <S318784AbSICPFJ>; Tue, 3 Sep 2002 11:05:09 -0400
Date: Tue, 03 Sep 2002 08:08:46 -0700
Message-ID: <3D74D07E.7040101@cs.rose-hulman.edu>
From: "Leslie Donaldson" <donaldlf@cs.rose-hulman.edu>
To: axp-kernel-list@redhat.com
Cc: linux-kernel@vger.kernel.org,
       "Leslie Donaldson- rose" <donaldlf@cs.rose-hulman.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: Kernel 2.5.33 successfully compiled
References: <200209031259.46719.o.pitzeier@uptime.at> <200209031357.48241.o.pitzeier@uptime.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I have had 3 errors so far.

1. add the following line to 
/usr/src/linux-2.5.X/linux-2.5.33/sound/core/device.c

#include <asm-generic/errno-base.h>

2. The following file need copied (a quick hack)

         cd include/asm
          cp ../asm-i386/kmap_types.h  .


3. The following error I haven't tried to fix yet.

process.c: In function `alpha_clone':
process.c:268: too few arguments to function `do_fork'
process.c: In function `alpha_vfork':
process.c:277: too few arguments to function `do_fork'
make[1]: *** [process.o] Error 1
make[1]: Leaving directory 
`/usr/src/linux-2.5.X/linux-2.5.33/arch/alpha/kernel'
make: *** [arch/alpha/kernel] Error 2

Just my 2 cents worth.

Leslie D.
Oliver Pitzeier wrote:

>On Tuesday 03 September 2002 12:59, Oliver Pitzeier wrote:
>[ ... ]
>  
>
>>It compiled successfull. I have not yet tried to reboot the machine because
>>it is used currently...
>>    
>>
>
>OK. I was in an error! I didn't saw the error because of a "make -j2"...
>
>I'll try to fix it now...
>
>  
>


-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills: Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  : http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n--- b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw LusCA++



