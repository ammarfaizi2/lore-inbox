Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSBNBev>; Wed, 13 Feb 2002 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289317AbSBNBem>; Wed, 13 Feb 2002 20:34:42 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:37106 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S289313AbSBNBec>; Wed, 13 Feb 2002 20:34:32 -0500
Message-ID: <3C6B1328.3060506@drugphish.ch>
Date: Thu, 14 Feb 2002 02:30:16 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: Improved ksymoops output
In-Reply-To: <200202130805.g1D85st16817@Port.imtp.ilyichevsk.odessa.ua> <3C6A3C26.4050908@drugphish.ch> <200202131223.g1DCN5t17824@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[reduced cc list, since I don't think the rest of the guys are 
interested in non-kernel related things]

> As already pointed out, format is horrendous, but prettier format
> requires much more serious hacking in ksymoops sources instead of my
> quick and very dirty tricks.

Yep, I see. After rethinking about this I have to agree with Russell. 
And I mean you still can't educate people to read FAQ's and manuals. 
Even with your output people that have no knowledge about this output 
will the things you mentioned as rationale. If one sees your inital oops 
where the hell does he get the information about calling your scripts 
without reading some document you must be providing. Well, and if he 
needs to read your docu he can as well read oops-tracing.txt. This is my 
little world, YMMV.

>>o run faster (5%) ;)
>>o should never have problems when one day there will be a lot of *.c
>>   files. In your approach LIST could someday not hold all entries
>>   anymore.
>>
> 
>>o simplifies the bash 'regexp' to snip away the '.c' and print the rest
>>
> 
> Hmm... is it faster than original?

I would say so, "b=${a%.*}" is always faster and legible than
                 "l=$((${#a}-2)); b=${a:0:$l}"
in the way it is used in your script.

Maybe not easily measurable but it seems obvious to me and is easier to 
read and overall time reported less time used for the whole script to 
run. ;)

And the second tiny cleanup regarding regexp was to use "${a:2}" instead 
of "${a:2:9999}". It should be an improvement too, if I remember the 
bash source correctly. But this is senseless nitpicking. The real speed 
improvement you get by avoiding the "LIST=`find -name '*.c' | xargs`".

>>I'm propably going to rewrite the python script in bash too, since I
>>don't run python on my distro (and I do not intend to use 2.5.x anytime
>>soon).
>>
> 
> Care to show the result to me?

Well, if there is a real interest from other parties, I will definitely 
spend some time to do it. OTOH, bash's regexp handling isn't as strong 
as python's AFAICS so it might be a pain in the ass to do it but this is 
getting off-topic.

Best regards,
Roberto Nibali, ratz

