Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSGVLY2>; Mon, 22 Jul 2002 07:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGVLY1>; Mon, 22 Jul 2002 07:24:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:52232 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316747AbSGVLYZ>; Mon, 22 Jul 2002 07:24:25 -0400
Message-ID: <3D3BEAC8.3080801@evision.ag>
Date: Mon, 22 Jul 2002 13:21:44 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>	<3D3BE17F.3040905@evision.ag> <20020722125347.B16685@lst.de> 	<3D3BE4C7.2060203@evision.ag> <1027341026.31782.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-07-22 at 11:56, Marcin Dalecki wrote:
> 
>>Christoph Hellwig wrote:
>>
>>>On Mon, Jul 22, 2002 at 12:42:07PM +0200, Marcin Dalecki wrote:
>>>
>>>
>>>>This is making the sysctl code acutally be written in C.
>>>>It wasn't mostly due to georgeous ommitted size array "forward
>>>>declarations". As a side effect it makes the table structure easier to
>>>>deduce.
>>>
>>>
>>>Please don't remove the trailing commas in the enums.  they make adding
>>>to them much easier and are allowed by gcc (and maybe C99, I'm not
>>>sure).
>>
>>It's an GNU-ism. If you have any problem with "adding vales", just
>>invent some dummy end-value. I have a problem with using -pedantic.
> 
> 
> You seem to have it permanently engaged 8)
> 
> If you are upset about that GNUism why doesn't your patch fix the other
> GNU-isms in the same file ? Also the entire kernel is *full* of GNU C
> extensions.

That's a common rumour. struct inits are going to go anyway.
The rest is only about 30 ({ ... }) in inclue/linux.
Of course some of the GNU extensions are actually usefull.
Trailing , at enum declarations make up for a nice shift reduce conflict
expirence in yacc. (And perhaps slower compilation...)

