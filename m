Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUCXG0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 01:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUCXG0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 01:26:21 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:22745 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263040AbUCXG0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 01:26:15 -0500
Date: Wed, 24 Mar 2004 14:22:04 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: ncunningham@users.sourceforge.net,
       "Dmitry Torokhov" <dtor_core@ameritech.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Cc: "Pavel Machek" <pavel@suse.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>  <200403231743.01642.dtor_core@ameritech.net>  <20040323233228.GK364@elf.ucw.cz>  <200403232352.58066.dtor_core@ameritech.net> <1080104698.3014.4.camel@calvin.wpcb.org.au>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5cry20s4evsfm@smtp.pacific.net.th>
In-Reply-To: <1080104698.3014.4.camel@calvin.wpcb.org.au>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 17:04:58 +1200, Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:

> Hi.
>
> On Wed, 2004-03-24 at 16:52, Dmitry Torokhov wrote:
>> OK, so you have an error condition on your CD. Does it prevent suspend from
>> completing? If not then I probably would not care about it till later when
>> I see it in syslog... I remember that the one thing that Pat complained
>> most often is your love for "panic"ing instead of trying to recover. In that

As easy, as clumsy.

>> case you understandably want as many preceding messages as possible left
>> intact on the screen to diagnose the problem. If error recovery is ever done
>> then some eye-candy probably won't hurt.

Error messages should be handled on a seperate VT eliminating the issue.

>
> Suspend2 is capable of aborting (there are four panics for dire
> situations; for the record swsusp.c has 14). I haven't tried to simulate
> a media error, so I'm not perfectly sure it would abort okay,

I'll do more testing there in due course.

How are bad blocks on a swap partition handled by the vm?

> but it
> wouldn't take too much to fix any issues.

Which reminds me of the "failed to read a chunk" message, the guys who reported
it got all quiet after telling them to do more badblocks testing without diskcaching or
using dd to write random data and read them back, so  likely was caused by
media problems.

Here we need more detailed error messages including the driver output  and the
screen  should be switched to a text VT so messages are visible. Also as the
error will cause resume to fail the system should be halted in this case.

IMO seperate message VT will eliminate all interference issues and further modularization
by keeping the eye candy seperate.

Regards
Michael
