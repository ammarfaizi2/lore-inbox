Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312713AbSCVP0Q>; Fri, 22 Mar 2002 10:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312712AbSCVP0H>; Fri, 22 Mar 2002 10:26:07 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:38406 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S312711AbSCVPZy>; Fri, 22 Mar 2002 10:25:54 -0500
Message-ID: <3C9B4CF5.9040303@loewe-komp.de>
Date: Fri, 22 Mar 2002 16:25:41 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Little, John" <JOHN.LITTLE@okdhs.org>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: fork() DoS?
In-Reply-To: <E7B0663E34409F45B77EFDB62AE0E4D2022360BD@s99mail02.okdhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Little, John wrote:

> I'm really not a programmer, just learning, but was able to bring the system
> to it's knees.  This is a redhat 7.2 kernel.  Is there anyway of preventing
> this?
> 
> #include <unistd.h>
> 
> void do_fork()
> {
>    pid_t p;
> 
>    p = fork();
>    do_fork();
> }
> 
> void main()
> {
>    for(;;)
>       do_fork();
> }
> 

in bash: help ulimit
ulimit: ulimit [-SHacdflmnpstuv] [limit]
     Ulimit provides control over the resources available to processes
     started by the shell, on systems that allow such control.  If an
     option is given, it is interpreted as follows:

         -S      use the `soft' resource limit
         -H      use the `hard' resource limit
         -a      all current limits are reported
         -c      the maximum size of core files created
         -d      the maximum size of a process's data segment
         -f      the maximum size of files created by the shell
         -l      the maximum size a process may lock into memory
         -m      the maximum resident set size
         -n      the maximum number of open file descriptors
         -p      the pipe buffer size
         -s      the maximum stack size
         -t      the maximum amount of cpu time in seconds
         -u      the maximum number of user processes

