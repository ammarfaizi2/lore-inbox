Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136138AbRDVN7Q>; Sun, 22 Apr 2001 09:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136134AbRDVN7J>; Sun, 22 Apr 2001 09:59:09 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:31248 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S136128AbRDVN4b>; Sun, 22 Apr 2001 09:56:31 -0400
Message-ID: <3AE2E4A7.7050606@eisenstein.dk>
Date: Sun, 22 Apr 2001 16:03:19 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: f5ibh <f5ibh@db0bm.ampr.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <200104221348.PAA31776@db0bm.ampr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

f5ibh wrote:

> Alan,
> 
> 
>>> /usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
>>> `rwsem_up_write_wake':rwsem.o(.text+0x3c6): undefined reference to
>>> `__builtin_expect'
>> 
>> Add a
>> 
>> #define __builtin_expect
> 
> 
> I had the same problem here, adding #define __builtin_expect in ../lib/rwsem.c
> solved the problem.
> 
> gcc is :
> 
> [jean-luc@debian-f5ibh] ~ # gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.3/specs
> gcc version 2.95.3 20010315 (Debian release)
> 

Just a 'me too'. I had the same problem, and the #define fixed it nicely...

bash-2.03# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)


-- Jesper Juhl - juhl@eisenstein.dk

