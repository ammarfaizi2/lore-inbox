Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSINVhE>; Sat, 14 Sep 2002 17:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSINVhE>; Sat, 14 Sep 2002 17:37:04 -0400
Received: from web40512.mail.yahoo.com ([66.218.78.129]:23448 "HELO
	web40512.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317541AbSINVhD>; Sat, 14 Sep 2002 17:37:03 -0400
Message-ID: <20020914214152.15900.qmail@web40512.mail.yahoo.com>
Date: Sat, 14 Sep 2002 14:41:52 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209141342090.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andre Hedrick <andre@linux-ide.org> wrote:
> 
> Hi Alex,
> 
> We (T13 Standards) only recently required (shall) all non-packet device to
> support flush cache.  No where does it state that a device supporting PM
> for a standby (shall), the key word here is "shall", issue a flush-cache.
I am assuming that a hard drive is a non-packet device. Let me make sure I'm
interpreting this correctly: older ( and some current ) drives may flush cache
on standby/sleep; current and future drives may not. In addition, older drives
may not support the flush cache command.

> I will not break support for older hardware, on a whim.
Not my intention.

> You said you can make a patch, please do so and apply it to your tree.
> Now, if you want the option, submit the patch for review.  For two or
> three days there has been no patch to test.
Still testing locally. I also want to fix the code so that the flush is
done before the standby.

> 
> To be absolutely honest, I really do not like to give options in the
> kernel-config build which can cause backwards compatablity problems.
This wouldn't be a config option. You would have to modify ide.c by
hand to disable standby.
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
