Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263800AbUEXBhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUEXBhO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUEXBhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:37:14 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:15783 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S263800AbUEXBhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:37:03 -0400
Date: Mon, 24 May 2004 03:37:01 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <Pine.LNX.4.44.0405240325180.15205-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Phy,

Could you also give the uname -a output of both the 2.4.x and
the 2.6.x kernels ? And also mention which make options you use ? :

make	  : 1 thread , load is around 1.00
make -j 2 : 2 theads , load is around 2.00
make -j 4 : 4 theads , load is around 4.00

# uname -a	(dual-Xeon SMP machine)
Linux jackson.stokkie.net 2.4.23abi #1 SMP Sun Jan 25 03:28:48 CET 2004 i686 unknown unknown GNU/Linux
                                       ^^^^

# uname -a	(poor PII 400 MHz machine)
Linux tapebox.stokkie.net 2.6.6 #1 Thu May 13 05:48:57 CEST 2004 i686 unknown unknown GNU/Linux
                                  ^^^ no SMP

Also , is your Opteron machine rather different as the mainstream Opteron
boards, i.e. are there some exotic drivers used ?

Regards,

Robert

> Just for more clarification, here is a perfect
> example:
>  
> 2.6.7-p1:
> 24.86user 51.77system 2:58.87elapsed 42%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13major+7591686minor)pagefaults
> 0swaps
>  
> 2.4.21:
> 28.68user 34.98system 1:12.34elapsed 87%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (5691267major+1130523minor)pagefaults
> 0swaps
>  
>  
> Both runs on the same machine with the same process
> (making headers).
>  
> Could someone give me some pointers/directions on
> where to look.
>  
> Thank you for your time.
> Phy
>  
> --- Phy Prabab <phyprabab@xxxxxxxxx> wrote:
>> Hello,
>> 
>> I need some help understanding what is at issue with
>> the extreme lsow down in build times for a custom
>> executable on different kernel versions. The
>> difference is pretty huge:
>> 
>> RH 2.4.20-13-7 : ~1m.10s
>> 2.4.22 : ~1m.40s
>> 2.4.26 : ~2m.15s
>> 2.6.1 : ~3m.40s
>> 2.6.2 : ~4m.00s
>> 2.6.3 : ~4m.00s
>> 2.6.6 : ~3m.15s
>> 2.6.6-mm4 : ~2m.10s
>> 2.6.6-mm5 : ~2m.50s
>> 2.6.7-p1 : ~2m.80s
>> (ran five times on every kernel to get approximate
>> time listed)
>> 
>> The question is, how can I get the newer kernels to
>> scream like the older kernels?
>> 
>> I have moved all files in question to the local disk
>> to rule out network issues (though the 2.6.x kernels
>> are faster at net access). I have run the make
>> command in debug mode and find no differnce betHz
>> w/8G
>> RAM.
>> 
>> Thank you for your assistance.
>> Phy
>> 
>> __________________________________
>> Do you Yahoo!?
>> Yahoo! Domains ? Claim yours for only $14.70/year
>> http://smallbusiness.promotions.yahoo.com/offer 

- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

