Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSA2O0C>; Tue, 29 Jan 2002 09:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSA2OZq>; Tue, 29 Jan 2002 09:25:46 -0500
Received: from ti200710a082-0324.bb.online.no ([148.122.9.68]:3076 "EHLO
	empire.e") by vger.kernel.org with ESMTP id <S289313AbSA2OYi>;
	Tue, 29 Jan 2002 09:24:38 -0500
Message-ID: <3C56B09B.2020508@freenix.no>
Date: Tue, 29 Jan 2002 15:24:27 +0100
From: frode <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: OOPS: kernel BUG at transaction.c:1857 on 2.4.17 while rm'ing 700mb file on ext3 partition.
In-Reply-To: <3C502E3A.9070909@freenix.no> <20020124191927.A9564@redhat.com> <3C509067.20108@freenix.no> <20020129141146.B1873@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> On Thu, Jan 24, 2002 at 11:53:27PM +0100, frode wrote:
>>>>I got the following error while rm'ing a 700mb file from an ext3 partition:
>>>>Assertion failure in journal_unmap_buffer() at transaction.c:1857:
>>>>"transaction == journal->j_running_transaction"
>>>Hmm --- this is not one I think I've ever seen before.
> Have you been able to reproduce any problems yet?

No reproducible problems, just more random oopses (like in
http://marc.theaimsgroup.com/?l=linux-kernel&m=101205570604468&w=2)

> iput() crash; page list crash; jbd transaction crash.  These look
> perfectly consistent with random memory corruption.
[memtest86]
> Try leaving it running overnight --- half an hour is very little time
> for a proper memory test.


Others have suggested this by mail also, and after running memtest for 4 hours, 
what do you know, a bit error occured.

Test#: 4
Pass#: 6
Failing address: 0aed1f64 - 174.8mb
Good pattern: 00080000
Bad pattern:  000a0000
Error bits:   00020000
Count: 1

I'm pretty sure that 256mb no-brand memory chip I added one year ago is to blame.
I'll try running memtest86 for 8+ hours as soon as feasible, but I guess I 
should just throw out the old RAM and put in some new.

I guess all I have to say is, sorry for wasting your time! :(

Anyway, thanks for your interest - at least I'm close to a solution now! :)

- Frode



