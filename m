Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSJUVl0>; Mon, 21 Oct 2002 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbSJUVl0>; Mon, 21 Oct 2002 17:41:26 -0400
Received: from mail.tpgi.com.au ([203.12.160.59]:26508 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S261724AbSJUVlY>;
	Mon, 21 Oct 2002 17:41:24 -0400
Message-ID: <3DB4752F.8080801@tpg.com.au>
Date: Tue, 22 Oct 2002 07:44:15 +1000
From: Bill Leckey <bleckey@tpg.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: System lockup.
References: <3DB3442A.7050002@tpg.com.au> <1035199818.27259.34.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-10-21 at 01:02, Bill Leckey wrote:
> 
>>I have a terminal server that's supporting up to 240 lines.  It's a 
>>2.4.17 kernel, and is running squid, and using the reiser file system to 
>>store log files, squid cache and other data.  About every day or so, the 
>>machine locks up.  The screen is blank, keyboard doesn't respond, the 
>>serial console I set up shows no 'dying gasp' and there is nothing in 
>>any of the system logs.
>>
>>This doesn't appear to be related to load as it has happened both during 
>>the busiest times and during the low times.
>>
>>I'm still servicing interrupts from our serial devices (on IRQ 11), so 
>>it seems interrupts are still happening.
>>
>>Beyond this, however, I have no idea where to go from here.  If anyone 
>>has any hints on what the problem might be, or even a way to gather more 
>>information, I would be grateful.
> 
> 
> Hardware details would be a useful starting point. Also if its
> uniprocessor or SMP. Finally have you considered 2.4.19 as 2.4.17 does
> have at least one known and fixed small PPP race. With 240 lines I guess
> you might actually hit that


Thanks for the reply Alan, much appreciated.

This system is running on Uniprocessor Intel P III's or Celerons (a 
variety of clock speeds) with  either 256 or 512Mb of memory and no swap 
(another experiment).  The Serial Hardware is a proprietary card (with a 
driver to cope with that, mostly copied from the standard serial driver) 
giving us the 240 serial lines.  I can give more detail on that and the 
driver if necessary.

Just offhand I have been through my  driver (with others making 
comments/suggestions) a few times to see if it's all my fault (which it 
may well still be).  The reason I know interrupts are still running is 
that on every interrupt I stick a different value onto the Parallel port 
and can see those changing as I would expect even when the system is 
locked up otherwise.

I am considering 2.4.19 but haven't had a chance to test with the 
driver/hardware yet.  That will be soon as it seems a good path to go down.

One thing I forgot was that there was the same failure with a system 
running without the squid.  It seems though, that a system running 
without squid will fail less often (two or more weeks between failures 
as opposed to a few days).

I hope I'm giving enough detail to be useful here.

Bill


-- 
Bill Leckey - Senior Software Design Engineer
TPG Research and Development
Ph: +61 2 62851711
Fax: +61 2 62853939

