Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136031AbRDVKqo>; Sun, 22 Apr 2001 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136030AbRDVKqf>; Sun, 22 Apr 2001 06:46:35 -0400
Received: from james.kalifornia.com ([208.179.59.2]:8504 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136026AbRDVKqQ>; Sun, 22 Apr 2001 06:46:16 -0400
Message-ID: <3AE2A7B9.10401@kalifornia.com>
Date: Sun, 22 Apr 2001 02:43:21 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.8.1+) Gecko/20010420
X-Accept-Language: en
MIME-Version: 1.0
To: CML2 <linux-kernel@vger.kernel.org>
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <200104220147.f3M1l2v126874@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

>>>>	Find . -name "*Some-Name*" -type f -print | xargs grep 'Some-Info'
>>>>	Hate answering with just one line of credible info , But .
>>>>
>>>The above would grep every file. It takes 1 minute and 9.5 seconds.
>>>So the distributed maintainer information does not scale well at all.
>>>
>>No it doesn't.  It allows you to search for files of a specific naming
>>pattern and greps those.  So if you needed to know the maintainers of all
>>the config.in files, you say:
>>
>>find . -name "*onfig.in" -type f -print | xargs grep 'P: '
>>
>
>That was an easy problem, and try it to see all the bad matches!
>This would be more normal:
>
>find . -type f | xargs egrep -i8 '^[^A-Z]*[A-Z]: .*(net|ip|tcp|eth|ppp)'
>
>That is not a nice and easy command for most people, and if it
>isn't exactly right you just wasted over a minute.
>

Eric *has* offered to write tools to simplify this.  I would guess that 
it would be something like:

kgrep [-t description] [-p person] [-m mailto] [-l mailing-list] [-w 
webpage] [-c config symbol] [-d date] [-s status]

-b

-- 
Three things are certain:
Death, taxes, and lost data
Guess which has occurred.
- - - - - - - - - - - - - - - - - - - -
Patched Micro$oft servers are secure today . . . but tomorrow is another story!



