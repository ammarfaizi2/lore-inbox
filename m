Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSLTOpV>; Fri, 20 Dec 2002 09:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSLTOpV>; Fri, 20 Dec 2002 09:45:21 -0500
Received: from users.ccur.com ([208.248.32.211]:31890 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S262317AbSLTOpU>;
	Fri, 20 Dec 2002 09:45:20 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200212201452.OAA10431@rudolph.ccur.com>
Subject: Re: [PATCH] joydev: fix HZ->millisecond transformation
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 20 Dec 2002 09:52:28 -0500 (EST)
Cc: george@mvista.com (george anzinger), bjorn_helgaas@hp.com (Bjorn Helgaas),
       marcelo@conectiva.com.br (Marcelo Tosatti),
       linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <20021220142443.A26184@ucw.cz> from "Vojtech Pavlik" at Dec 20, 2002 02:24:43 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ repost -- I am going to have to get outgoing mail fixed on my lkml-reading
 machine ]

> On Fri, Dec 20, 2002 at 02:41:50AM -0800, george anzinger wrote:
>> Bjorn Helgaas wrote:
>>> 
>>> * fix a problem with HZ->millisecond transformation on
>>>   non-x86 archs (from 2.5 change by vojtech@suse.cz)
>>> [...]
>>> +#define MSECS(t)       (1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
>>> [...]
> Though it might be easier to say (1000 * t) / HZ, now that I think about
> it.

The more complex version avoids integer overflow for more values of 't'
in the (1000 * t) subexpression.

Joe
