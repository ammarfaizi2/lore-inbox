Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRDWQRD>; Mon, 23 Apr 2001 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133108AbRDWQQo>; Mon, 23 Apr 2001 12:16:44 -0400
Received: from fe020.worldonline.dk ([212.54.64.196]:30735 "HELO
	fe020.worldonline.dk") by vger.kernel.org with SMTP
	id <S132805AbRDWQQb>; Mon, 23 Apr 2001 12:16:31 -0400
Message-ID: <3AE456F8.4010707@eisenstein.dk>
Date: Mon, 23 Apr 2001 18:23:20 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with this?
In-Reply-To: <3AE449A3.3050601@eisenstein.dk> <200104231537.f3NFblv08166@mobilix.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> Jesper Juhl writes:
>
>> All the above does is to remove the last comma from 3 enumeration
>> lists.  I know that gcc has no problem with that, but to be strictly
>> correct the last entry should not have a trailing comma.
> 
> 
> But it's more people-friendly to have that trailing comma. It makes
> adding new enumerations just slightly easier, and also makes it easier
> to manually apply failed patches. I'd rather see those trailing commas
> left in.

> 

You are right. As several people have pointed out to me it is in fact 
legal to have the trailing comma. And it _does_ make it easier to add 
new lines.
At least I have learned a lesson here; be 100% sure of your facts before 
posting to linux-kernel ;)

> 
>> Another example is the following line (1266) from linux/include/net/sock.h
>> 
>>          return (waitall ? len : min(sk->rcvlowat, len)) ? : 1;
>> 
>> To be strictly correct the second expression (between '?' and ':' ) 
>> should not be omitted (all you guys already know that ofcourse).
> 
> 
> Yeah, that one's pretty ugly and unreadable.
> 

That function (sock_rcvlowat()) only gets called a few places, so I'll 
see if I can figure out exactely what's going on and come up with a 
better construct (it might take me ages, but I'm determined to learn to 
find my way around this code)...

> 
> Go ahead and make suggestions. I expect some things will be accepted,
> some rejected (just like I did). Steer clear of any brace or tabbing
> style changes, though.
> 

Ok, I'll continue reading code and keep my eyes open for these things.

[...]

> The goal should *not* be to shut up gcc. The goal should be to produce
> more readable code and to fix bugs. Gcc is merely a tool. And a flawed
> one, at that.
> 

I'll remember that. Thank you to everyone who have taken their time to 
answer my post, you have all been very helpfull!

- Jesper Juhl - juhl@eisenstein.dk

