Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSBOMXT>; Fri, 15 Feb 2002 07:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288614AbSBOMXC>; Fri, 15 Feb 2002 07:23:02 -0500
Received: from [195.63.194.11] ([195.63.194.11]:11272 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S288611AbSBOMWl>; Fri, 15 Feb 2002 07:22:41 -0500
Message-ID: <3C6CFD7A.30503@evision-ventures.com>
Date: Fri, 15 Feb 2002 13:22:18 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
CC: Michael Sinz <msinz@wgate.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <3C6BE18F.7B849129@wgate.com> <20020215124036.C23673@unthought.net> <3C6CF4AA.8040808@evision-ventures.com> <20020215131320.E23673@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:

>On Fri, Feb 15, 2002 at 12:44:42PM +0100, Martin Dalecki wrote:
>
>>Jakob Østergaard wrote:
>>
>...
>
>>>What I want is "core.[process name]" eventually with a ".[pid]" appended.  A
>>>flexible scheme like your patch implements is very nice.   Actually having
>>>the core files in CWD is fine for me - I mainly care about the file name.
>>>
>>Please execute the size command on the core fiel:
>>
>>size core
>>
>>to see why this isn't needed.
>>
>
>Huh ?
>
>I suppose you mean, that I can get the name of the executable that caused the
>core dump, when running size - right ?
>
>Well, you can do that easier with the file command.
>
>But that doesn't prevent my 7 other processes from overwriting the core file
>of the 8'th process which was the first one to crash.   Multi-process systems
>can, on occation, produce such "domino dumps".   Separate names is a *must have*.
>
This point I fully agree with. And in fact 2.4.17 already does it the 
core.{pid} way.

>And having process names is nicer than having PIDs - I don't mind if my core
>files are over-written on subsequent runs, actually it's nice (keeps the disks
>from filling up).
>
They can get long and annoying... They are not suitable for short name 
filesystems... They provide a good
hint for deliberate overwrites.... and so on. Basically I think this 
would be too much of the good.

>



