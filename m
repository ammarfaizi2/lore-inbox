Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317219AbSFGIbT>; Fri, 7 Jun 2002 04:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317223AbSFGIbS>; Fri, 7 Jun 2002 04:31:18 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:58127 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317219AbSFGIbS>; Fri, 7 Jun 2002 04:31:18 -0400
Message-ID: <3D006FDE.8050100@loewe-komp.de>
Date: Fri, 07 Jun 2002 10:33:34 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <E17G6ZR-0000F2-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <Pine.LNX.4.44.0206060930240.5920-100000@home.transmeta.com> you wri
> te:
> 
>>Do we have major and minor numbers for sockets and populate /dev
>>with them? No. And as a result, there has _never_ been any sysadmin
>>problems with either.
>>
> 
> Ummm... you don't do much network programming, do you Linus?  Don't
> confuse familiarity with fondness: the socket API is *not* a good
> model to copy.
> 
> 
>>You already have to have a system call to bind the particular fd to the
>>futex _anyway_, so do the only sane thing, and allocate the fd _there_,
>>and get rid of that stupid and horrible /dev/futed which only buys you
>>pain, system administration, extra code, and a black star for being
>>stupid.
>>
> 
> Yet another special way to create a special fd?  Hmm...
> 
> That might be better than what I proposed, but it's not the epitomy of
> taste either.
> 

What about /proc/futex then? Less adminstrative work, clean interface
(also for shell scripts like Alan suggested).
Al Viro would like this, it's more like Plan9 or QNX6. :)

Give it an entry in the namespace, why not with sockets (unix and ip) also?



