Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJKAPF>; Thu, 10 Oct 2002 20:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262245AbSJKAOr>; Thu, 10 Oct 2002 20:14:47 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:8687 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S262243AbSJKANl>; Thu, 10 Oct 2002 20:13:41 -0400
Message-ID: <3DA61990.8060607@mvista.com>
Date: Thu, 10 Oct 2002 17:21:36 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sridhar vaidyanathan <sridharv@ufl.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 
References: <1034295079.3da61727ec718@webmail.health.ufl.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



sridhar vaidyanathan wrote:

>I am trying to debug a kernel over a remote serial console. I get 
>Ignoring packet error ..
>
I have seen this and in my case, it had to do with printks coming over 
the serial link with console redirection.

>kgdb page suggests that it might be due to the speed mismatch. i tried 
>stty ispeed 9600 ospeed 9600 < /dev/ttyS0 
>on the development machine and have passed serial=0,9600n8 option and 
>gdbbaud=9600 via lilo to the debug kernel. 
>
>when i run 
>%stty speed 
>on the development machine it still reports 38400.
>so i changed the gdbbaud and serial= values to 38400 on the test machine. even 
>this doesn't work.
>any ideas?also on the development machine when i invoke 
>%gdb bzImage 
>
try gdb vmlinux.  This is the uncompressed image that gdb knows how to 
read.  bzImage is the compressed kernel that you should boot.  The 
vmlinux file should match the bzImage file.

>gdb reports that bzImage is not an Executable file format and it is unable to 
>recognize the format. what is the problem?
>-sridhar
>ps: i have tried redirecting the kernel messages( without patching it with 
>kgdb) over the serial line and read it with minicom . that works fine.
>
>please email as i am not subscribed.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

