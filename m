Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSE0OfZ>; Mon, 27 May 2002 10:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316638AbSE0OfY>; Mon, 27 May 2002 10:35:24 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:43018 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316636AbSE0OfX>; Mon, 27 May 2002 10:35:23 -0400
Message-ID: <3CF2449E.9000905@loewe-komp.de>
Date: Mon, 27 May 2002 16:37:18 +0200
From: Peter =?ISO-8859-15?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andreas Hartmann <andihartmann@freenet.de>, linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no>	<actahk$6bp$1@ID-44327.news.dfncis.de>  <3CF23893.207@loewe-komp.de> <1022513156.1126.289.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-05-27 at 14:45, Peter Wächtler wrote:
> 
>>There is still the oom killer (Out Of Memory).
>>But it doesn't trigger and the machine pages "forever".
>>Usually kswapd eats the CPU then, discarding and reloading pages,
>>searching lists for pages to evict and so on.
>>
> 
> On a -ac kernel with mode 2 or 3 set for overcommit you have to run out
> of kernel resources to hang the box. It won't go OOM because it can't.
> That wouldn't be a VM bug but a leak or poor handling of kernel
> allocations somewhere. Sadly the changes needed to do that (beancounter
> patch) were things Linus never accepted for 2.4
> 

I heard of the "beancounter patch" several times now.
Where is it - that beancounter patch? What does it besides bean counting ;-)
ah, googled it:

ftp://ftp.sw.com.sg/pub/Linux/people/saw/kernel/user_beancounter/UserBeancounter.html

I think we will get another candidate for beancounting: the futexes are locking
user pages.. and I already thought about accounting with
setrlimit/ulimit and "max locked memory (kbytes)"

