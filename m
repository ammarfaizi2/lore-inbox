Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279897AbRJ3JLr>; Tue, 30 Oct 2001 04:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279822AbRJ3JLi>; Tue, 30 Oct 2001 04:11:38 -0500
Received: from mail.esiee.fr ([147.215.1.3]:37637 "HELO mail.esiee.fr")
	by vger.kernel.org with SMTP id <S279896AbRJ3JLY>;
	Tue, 30 Oct 2001 04:11:24 -0500
Message-ID: <3BDE6ED9.7070401@esiee.fr>
Date: Tue, 30 Oct 2001 10:11:53 +0100
From: Matthieu Delahaye <delahaym@esiee.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011019
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Sureshkumar Kamalanathan <skk@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to write System calls?
In-Reply-To: <3BDD3AA1.18FCC633@sasken.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, I propose you to have a look on "Linux Kernel 2.4 Internals" from 
Tigran Aivazian. You can read it from the LDP at exact URL: 
http://www.linuxdoc.org/LDP/lki/index.html
In this, you'll probably see that syscalls are hardcoded (file 
arch/xxx/kernel/entry.S  on your kernel tree).
This means, AFAIK, you cannot implements a syscall function in a module ;-)
One other way is using  your modules to implements char drivers and use 
ioctl() as if it was yours syscalls. This method is generally 
recommended to users who wants to implement new sayscalls.


Am I wrong?

Regards,
Matthieu

Sureshkumar Kamalanathan wrote:

>Hi All,
>  Good day!
>  I have 2.4.4 kernel.  I have to write some system calls for
>interaction with the kernel from the userland.  Can any of you tell me
>where I can get the information regarding this?  
>  I have the Linux Kernel Internals by Beck and others.  But it gives
>the procedure only for 2.2.x.
>  Moreover I need to implement these system calls as Loadable modules.
>  Any pointers in this regard will be highly appreciated and I'll very
>grateful!!
>
>  Thanks in advance,
>
>Regards,
>Suresh.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



