Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270458AbUJTU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbUJTU7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270543AbUJTUcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:32:02 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:20484 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S270534AbUJTU1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:27:32 -0400
Date: Wed, 20 Oct 2004 22:27:12 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Register corruption --patch
Message-ID: <20041020202711.GA3685@finwe.eu.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410191112100.4820@chaos.analogic.com> <20041020003408.GA6101@finwe.eu.org> <Pine.LNX.4.61.0410200836020.10672@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410200836020.10672@chaos.analogic.com>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote

> On Wed, 20 Oct 2004, Jacek Kawa wrote:
> >Richard B. Johnson wrote:
> >
> >>This 'C' compiler destroys parameters passed to functions
> >>even though the code does not alter that parameter.
[...]
> >>I have been having trouble with mysterious things like:
> >[...]
> >>(4) Data errors in email.
> >>(5) Network connections failing to go away `netstat -c` shows
> >>hundreds of lines of very old history.
> >>... etc.
> >
> >Having troubles with some strange (and -as it seems- temporary)
> >data corruptions here[*], I was wondering, whether would it be
> >posiible to easily diagnose this somehow?
> >
> >[*] like diff running serval times over same two files can
> >   only once in a while show one character altered
[...]
> If the corruption goes away, you've either fixed the problem
> or have changed the size of something so that something that
> was getting trashed before by some completely-unrelated code,
> is now able to survive.

In a way patch helped to track down the error: while compiling 
new kernel[*] I was hit by SEGFAULT, so I ran memtest.... 
Well, it's not new RAM, so it goes away now, and I will give 
a plain 2.6.9 next try.

[*] I compiled -rc4 and -final (well, even twice) not so long
    ago and everythig was fine those days. :/

> Without some specific OOPS, some code to trace, it's just
> a crap game. But, the semaphore patch can't hurt anything.

Thanks for explanation. I will apply workaround in case
of 'mysterious' corruption reappear.

BTW, could it be, that CONFIG_REGPARM makes problem visible with
     your compiler (somehow)?

-- 
Jacek Kawa   **So, logically...  If she weighs the same as a duck,
            she's made of wood. And therefore-? A witch! A witch!**
