Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274106AbRISRSI>; Wed, 19 Sep 2001 13:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274109AbRISRR6>; Wed, 19 Sep 2001 13:17:58 -0400
Received: from [208.129.208.52] ([208.129.208.52]:50438 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274106AbRISRRp>;
	Wed, 19 Sep 2001 13:17:45 -0400
Message-ID: <XFMail.20010919102126.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA80108.C830D602@kegel.com>
Date: Wed, 19 Sep 2001 10:21:26 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: re: [PATCH] /dev/epoll update ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Sep-2001 Dan Kegel wrote:
> Davide wrote:
> 
>> The /dev/epoll patch has been updated :
>> 
>> *) Stale events removal
>> *) Help in Configure.help ( thanks to David E. Weekly )
>> *) Fit 2.4.9
>> ...
>> http://www.xmailserver.org/linux-patches/nio-improve.html
> 
> Davide, 
> I'm getting ready to stress-test /dev/epoll finally.
> In porting my Poller_devpoll.{cc,h} to support /dev/epoll, I noticed
> the following issues:

Pls wait the end of today to let me update the patch correctly.


> 
> 2. The names made visible to userland by your patch do not follow
>    a consistent naming convention.  May I suggest that you use
>    EPOLL_ as a uniform prefix, and epoll.h as the user-visible include file?
>    http://www.opengroup.org/onlinepubs/007908799/xsh/compilation.html
>    shows that Posix cares greatly about this kind of namespace issue,
>    and it'd be nice to follow their lead, even though this isn't a Posix
>    interface.

Posix spoke :) I'll change it in the next versions.



> 3. You modify asm/poll.h.  Can your modifications be restricted to epoll.h 
>    instead?  (Hey, I don't know much, maybe there's a good reason you did this.)

This is where flags are stored and using an external file could lead to a collision
when other coders will add flags. IMHO is better to have a centralized definition
of these flags.




- Davide

