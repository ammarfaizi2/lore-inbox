Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbREOVAS>; Tue, 15 May 2001 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbREOVAK>; Tue, 15 May 2001 17:00:10 -0400
Received: from anubis.han.de ([212.63.63.3]:11012 "EHLO anubis.han.de")
	by vger.kernel.org with ESMTP id <S261512AbREOU7T>;
	Tue, 15 May 2001 16:59:19 -0400
Date: Tue, 15 May 2001 22:59:10 +0200
From: Jens-Uwe Mager <jum@anubis.han.de>
Message-Id: <200105152059.f4FKxAU00997@anubis.han.de>
To: jsimmons@transvirtual.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <mng==Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>
In-Reply-To: <mng==Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com> <mng==Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In hannet.ml.linux.rutgers.linux-kernel, you wrote:
>
>> What Al is saying, and what makes perfect sense is that you generate a
>> separate fd for each "pipe". It's even more obvious in the case of USB,
>> because, by golly, the things are actually _called_ "pipes" in the USB
>> documentation, which should have made people make the immediate
>> association. Instead of doing
>
>Graphics cards are the same way. Especially high end ones. They have pipes
>as well. For low end cards you can think of them as single pipeline cards
>with one pipe.
>
>> See?
>>
>> Don't get boxed in by thinking that you only have one fd. Even if you have
>> only one _device_node_, you can have multiple fd's. In fact, you can, with
>> the Linux VFS layer, fairly easily do things like
>>
>> 	mknod /dev/fd0 c X Y
>>
>> and then use
>>
>> 	fd = open("/dev/fd0/colourspace", O_RDWR);
>
>Yipes!! I have to say UNIX has a tendency to teach you ioctl is the only
>way. I have never thought outside of the box nor see anyone else in this
>manner. This is absolutely brillant!!! I can see alot of possibilties with
>this.

Actually that sounds pretty much like multiplexed character special
devices that were available in earlier Unix versions and are still
available under AIX. And they are used for these kind of things, the
device driver gets the rest of the unparsed path name and reacts
accordingly. See:

http://www.rs6000.ibm.com/doc_link/en_US/a_doc_lib/libs/ktechrf1/ddmpx.htm

-- 
Jens-Uwe Mager	<pgp-mailto:62CFDB25>
