Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276766AbRJQNqj>; Wed, 17 Oct 2001 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276720AbRJQNqa>; Wed, 17 Oct 2001 09:46:30 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:42762 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S276682AbRJQNqR>; Wed, 17 Oct 2001 09:46:17 -0400
Message-ID: <3BCD89FA.6050209@eisenstein.dk>
Date: Wed, 17 Oct 2001 15:39:06 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: console_loglevel is broken on ia64
In-Reply-To: <2784.1003325102@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> kernel/printk.c has this abomination.
> 
> /* Keep together for sysctl support */
> int console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
> int default_message_loglevel = DEFAULT_MESSAGE_LOGLEVEL;
> int minimum_console_loglevel = MINIMUM_CONSOLE_LOGLEVEL;
> int default_console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
> 
> sysctl assumes that the 4 variables occupy contiguous storage.  They
> don't on ia64, console_loglevel is separate from the other variables.
> 
>   echo 6 4 1 7 > /proc/sys/kernel/printk
>   
> on ia64 overwrites console_loglevel and the next 3 integers, whatever
> they happen to be.  On 2.4.12 it corrupts console_sem, other ia64
> kernels will corrupt different data.
> 
> Does anybody fancy a small project to clean up these variables?

I would like to give it a try. Seems like a good little project for one 
who is trying to learn his way around the kernel :)  It will probably 
take me a lot longer than one of the experienced kernel hackers and 
would probably not be perfect on the first try, but I'm willing to 
invest some time in it.


Best regards,
Jesper Juhl



