Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752340AbWCFJYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbWCFJYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbWCFJYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:24:06 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:6544 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1752338AbWCFJYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:24:04 -0500
Message-ID: <440BFFAB.2040405@aitel.hist.no>
Date: Mon, 06 Mar 2006 10:23:55 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jonathan@jonmasters.org
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>	 <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com> <35fb2e590603051350o27a00274r4566e65e3fb99721@mail.gmail.com>
In-Reply-To: <35fb2e590603051350o27a00274r4566e65e3fb99721@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:

>On 3/5/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
>  
>
>>On 3/5/06, Jon Masters <jonmasters@gmail.com> wrote:
>>    
>>
>
>  
>
>>>I'm fed up with those finds running whenever I power on.
>>>      
>>>
>
>  
>
>>You run updatedb at boot time?
>>    
>>
>
>No, but said box will catch up cron jobs on boot.
>
>  
>
>>Why not run it from cron at night like most people do?
>>    
>>
>
>That's not the point. It usually does. I'm interested to know if
>anyone has written a daemon that can sit and just do this
>synchronously on my desktop - then not only do I /not/ have to run
>updatedb every day but I can also have a locate that is always up to
>the minute.
>  
>
I haven't heard about anyone doing this.  You could modify
the VFS to notify you everytime a file is created, moved or deleted.
That should give you what you want, but at the cost of delaying
those operations.

Another option would be to make a filesystem that stores its
directory structure (or a copy of it) in a single file, so that
a locate-like program can do quick lookups of the always-correct
data.

Helge Hafting
