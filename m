Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268304AbTCAMiC>; Sat, 1 Mar 2003 07:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268364AbTCAMiC>; Sat, 1 Mar 2003 07:38:02 -0500
Received: from tomts25.bellnexxia.net ([209.226.175.188]:63924 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268304AbTCAMiA>; Sat, 1 Mar 2003 07:38:00 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: anticipatory scheduling questions
To: Andrew Morton <akpm@digeo.com>, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sat, 01 Mar 2003 07:48:45 -0500
References: <fa.g5ol5kg.cgoq0g@ifi.uio.no> <fa.hp882fv.1u0orj9@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030301124845.D92E31156@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>>
>> ----- Original Message -----
>> > > It wasn't a typo... In fact, both deadline and AS give roughly the
>> > > same timings (one second up or down). But I
>> > > still don't understand why 2.5 is performing so much worse than 2.4.
>> >  
>> > Me either.  It's a bug.
>> >  
>> > Does basic 2.5.63 do the same thing?  Do you have a feel for when it
>> > started happening?
>>  
>> This has happened since the moment I switched from 2.4 to 2.5.63-mm1.
> 
> You have not actually said whether 2.5.63 base exhibits the same problem.
> From the vmstat traces it appears that the answer is "yes"?
> 
>> > > Could a "vmstat" or "iostat" dump be interesting?
>> > 2.4 versus 2.5 would be interesting, yes.
>>  
>> I have retested this with 2.4.20-2.54, 2.5.63 and 2.5.63-mm1...
>> and have attached the files to this message
> 
> Thanks.  Note how 2.4 is consuming a few percent CPU, whereas 2.5 is
> consuming 100%.  Approximately half of it system time.
> 
> It does appear that some change in 2.5 has caused evolution to go berserk
> during this operation.
> 
> 
>> (I think pasting them
>> here would result in wrapping, making it harder to read).
>>  
>> If you need more testing or benchmarking, ask for it :-)
> 
> Thanks for your patience.
> 
> The next step please is:
> 
> a) run top during the operation, work out which process is chewing all
>    that CPU.  Presumably it will be evolution or aspell
> 
> b) Do it again and this time run
> 
> strace -p $(pidof evolution)  # or aspell
> 
> This will tell us what it is up to.

It might also help to know the filesystem(s) being used.

Ed Tomlinson
