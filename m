Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRKVJ6Q>; Thu, 22 Nov 2001 04:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKVJ6G>; Thu, 22 Nov 2001 04:58:06 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:48565
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S275224AbRKVJ5z>; Thu, 22 Nov 2001 04:57:55 -0500
Message-ID: <3BFD0BB3.2000000@debian.org>
Date: Thu, 22 Nov 2001 15:29:07 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: ncw@axis.demon.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Asm style
In-Reply-To: <fa.derh1nv.1h0ai0b@ifi.uio.no> <fa.njuqm5v.100c5ak@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ncw@axis.demon.co.uk wrote:
> Giacomo Catenazzi wrote:
>> 
>> not ANSI C. The trailing \ is understood only in marco definitions
>> (and outside strings)
>> 
> gcc begs to differ
> 
> /* z.c */
> #include <stdio.h>
> 
> int main(void)
> {
>     printf("This is a string\n\
> with continuation characters\n");
>     return 0;
> }
> 
> $ gcc -Wall -pedantic -ansi z.c -o z
> [silence]
> 
> Remove the \ and you get
> 
> z.c:5: warning: string constant runs past end of line
> z.c: In function `main':
> z.c:5: warning: ANSI C forbids newline in string constant
> 

gcc should warn in both case (when calling it with -pedantic -ansi).
But forget my comment:
Talking about ANSI C for asm construct doen't make much sense.

If gcc people will maintain (in long future) the syntax of
trailing \ + NL, I agree to use it into kernel.

	giacomo


