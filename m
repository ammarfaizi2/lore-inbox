Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130549AbRARQDX>; Thu, 18 Jan 2001 11:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRARQDS>; Thu, 18 Jan 2001 11:03:18 -0500
Received: from jane.hollins.EDU ([192.160.94.78]:54800 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S135592AbRARQDB>;
	Thu, 18 Jan 2001 11:03:01 -0500
Message-ID: <3A6713AC.1010904@hollins.edu>
Date: Thu, 18 Jan 2001 11:02:52 -0500
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre8 i686; en-US; m18) Gecko/20010116
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.4.1-pre8
In-Reply-To: <Pine.LNX.4.30.0101172312550.18642-100000@cola.teststation.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Urban.

I'm connecting to a Win2K server (same share between computers).  A 
slight change in my previous post:  my dual P2 w/320MB appears to be 
running 2.4.0-ac9 instead of 2.4.1-pre8.  The bigmem machine (1gb mem) 
had the oops on 2.4.0-ac9 but before reporting I thought I'd try 
2.4.1-pre8 and see if it also had the oops.  (This morning the small mem 
machine had a problem but I'll put that in a separate email.)

Earlier I had tried 2.4.0-test12 but it partially scrambled my root 
partition so I went back to 2.2.19-pre2.  After the oops I tried 2.4.0 
straight but when it was booting it decided my root partition had been 
umounted not-cleanly and decided it needed to do lots of icky things to 
my root partition.  I just rebooted it (without letting it do any 
changes) and went back into 2.4.1-pre8 and let it clean up the root 
partition.  So I don't know if 2.4.0 straight would do this (apparently 
it does from other people's reports) since 2.4.0 didn't want to play 
nice on my machine.

Since I can't do without smbfs I guess I'll have to do without bigmem.  
Please let me know when you're ready to test some fixes; I would be glad 
to help testing.

--Scott


Urban Widmark wrote:

> On Wed, 17 Jan 2001, Scott A. Sibert wrote:
> 
>> I'm consistently getting an oops when accessing any smbfs mount whether
>> running 'ls' inside the smbfs mount or hitting TAB for filename
>> completion of a directory in an smbfs mount.  I have another machine
>> (dual P2/300 w/320MB memory) that does not have this problem.  The P2
> 
> 
> That other machine is not compiled with bigmem, I assume.
> 
> 
>> Ethernet is compiled into the kernel as is smbfs (not as modules).  I've
>> compiled this kernel with 4GB bigmem support (otherwise I only get 8xxMB
>> total).
> 
> 
> The smbfs cache code in 2.4.0 doesn't work with bigmem. For now disable
> bigmem or don't use smbfs, it's oopsing all the time.
> 
> Rainer Mager reported the same thing yesterday ("Oops with 4GB memory
> setting in 2.4.0 stable" if you want to read the thread).
> 
> I am currently looking into this ... what kind of server are you
> connecting to? win2k/NT4/9x? It is easier to test with those than the more
> exotic OS/2 & NetApp.
> 
> /Urban
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
