Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSLFUCR>; Fri, 6 Dec 2002 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267586AbSLFUCR>; Fri, 6 Dec 2002 15:02:17 -0500
Received: from mail.ccur.com ([208.248.32.212]:7696 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S265705AbSLFUCP>;
	Fri, 6 Dec 2002 15:02:15 -0500
Message-ID: <3DF10408.83ECE6C8@ccur.com>
Date: Fri, 06 Dec 2002 15:09:44 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: [PATCH] compatibility syscall layer (let's try again)
References: <Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

Hi Linus,

Sorry about my last message (which quoted everything but didn't add 
anything).  I shouldn't try to answer email and talk on the phone at
the same time.

> It's been tested, and the only problem I found (which is kind of
> fundamental) is that if the system call gets interrupted by a signal and
> restarted, and then later returns successfully, the partial restart will
> have updated the "remaining time" field to whatever was remaining when the
> restart was started.
> 

George's Posix timers patch sets the time remaining to zero in the 
success case.  I think this is the right thing to do.  

I don't have a copy of the spec in front of me.  IIRC, it says that you have
to set the time remaining in the interrupted case.  It says nothing 
about setting it on the success case.  I would leave the lawyers out
of writing software. 

I wish the IEEE would make the Posix specs available online for free.
I gave the IEEE money for years...

Jim Houston - Concurrent Computer Corp.
