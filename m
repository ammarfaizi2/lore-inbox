Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSFJUPK>; Mon, 10 Jun 2002 16:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSFJUPJ>; Mon, 10 Jun 2002 16:15:09 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:48451 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S316051AbSFJUPH>; Mon, 10 Jun 2002 16:15:07 -0400
Message-ID: <3D05089D.6030604@blue-labs.org>
Date: Mon, 10 Jun 2002 16:14:21 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Kristian Peters <kristian.peters@korseby.net>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: -ac series won't compile without fix
In-Reply-To: <20020605134945.7ad22093.kristian.peters@korseby.net> <30073.1023366073@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 556; timestamp 2002-06-10 16:14:10, message serial number 4508
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So in other words...

$ tar zxf linux.tar.bz2
$ patch -p1 < patch
$ cp /boot../.config .
$ make oldconfig
$ make dep clean
$ make -j3 bzImage
$ make dep
$ make -j3 bzImage

That about cover it?  Still doesn't work.  I'm using -ac2.

-d


David Woodhouse wrote:

>kristian.peters@korseby.net said:
>  
>
>>I'm unable to compile the -ac series correctly.  A "make mrproper"
>>does not help here.
>>    
>>
>
>  
>
>>make[1]: *** No rule to make target `/usr/src/linux-2.4.19-pre10-ac1/fs/inflate_fs/infblock.h', needed by `/usr/src/linux-2.4.19-pre10-ac1/fs/inflate_fs/infcodes.h'.  Stop.
>>    
>>
>
>This is one of many symptoms of the broken kbuild system in current 2.4 and
>2.5 kernels. You need to re-run 'make dep'.
>
>--
>dwmw2
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

