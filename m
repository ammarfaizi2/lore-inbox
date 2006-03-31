Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWCaR7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWCaR7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWCaR7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:59:32 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:63125 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932176AbWCaR7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:59:31 -0500
Message-ID: <51443.128.237.233.65.1143827969.squirrel@128.237.233.65>
In-Reply-To: <1458d9610603301725r127cc73djb125ae56c992cb99@mail.gmail.com>
References: <5W8lY-1wF-29@gated-at.bofh.it> <442C81BC.7030605@shaw.ca>
    <1458d9610603301725r127cc73djb125ae56c992cb99@mail.gmail.com>
Date: Fri, 31 Mar 2006 12:59:29 -0500 (EST)
Subject: Re: cannot get clean 2.4.20 kernel to compile
From: "George P Nychis" <gnychis@cmu.edu>
To: "Sumit Narayan" <talk2sumit@gmail.com>
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually that helped, i had no linux symlink, after creating it, i got alot further into the build, however now i get:
In file included from ide-cd.c:318:
ide-cd.h:440: error: long, short, signed or unsigned used invalidly for `slot_tablelen'
make[3]: *** [ide-cd.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/ide'

Any more ideas? :)

> From the error output 1, it appears that your directory include/asm is not
> a link to include/linux. Can you check that?
> 
> Otherwise, simply delete the directory include/asm and re-compile the 
> kernel from start; it should work.
> 
> -- Sumit
> 
> 
> 
> On 3/31/06, Robert Hancock <hancockr@shaw.ca> wrote:
>> George P Nychis wrote:
>>> Hi,
>>> 
>>> I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked
>>> its sign, and no matter what I try I cannot get it to compile.
>>> 
>>> I do a make mrproper, I then do make dep which is fine, but then i
>>> try "make bzImage modules modules_install", selecting all the
>>> defaults, and get an SMP header error: 
>>> http://rafb.net/paste/results/QzIq7v86.html
>>> 
>>> I then disable SMP support and get: 
>>> http://rafb.net/paste/results/muYA9t12.html
>>> 
>>> I even tried using my config from the 2.4.32 kernel which works
>>> perfectly fine, and I also get the sched errors.
>> 
>> What gcc version? Some old kernels might not be buildable with newer 
>> compilers.
>> 
>> -- Robert Hancock      Saskatoon, SK, Canada To email, remove "nospam"
>> from hancockr@nospamshaw.ca Home Page: http://www.roberthancock.com/
>> 
>> - To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org More
>> majordomo info at  http://vger.kernel.org/majordomo-info.html Please
>> read the FAQ at  http://www.tux.org/lkml/
>> 
> 
> 


-- 

