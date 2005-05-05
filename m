Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVEEAm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVEEAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 20:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVEEAm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 20:42:26 -0400
Received: from alog0211.analogic.com ([208.224.220.226]:43433 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261981AbVEEAmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 20:42:21 -0400
Date: Wed, 4 May 2005 20:42:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Alex Riesen <raa.lkml@gmail.com>
cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
In-Reply-To: <81b0412b0505041406297427ba@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505042039460.22366@chaos.analogic.com>
References: <4279084C.9030908@free.fr> <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
 <20050504191604.GA29730@nevyn.them.org> <81b0412b0505041406297427ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Alex Riesen wrote:

> On 5/4/05, Daniel Jacobowitz <dan@debian.org> wrote:
>> On Wed, May 04, 2005 at 02:16:24PM -0400, Richard B. Johnson wrote:
>>> The kernel doesn't do SIGSTOP or SIGCONT. Within init, there is
>>> a SIGSTOP and SIGCONT handler. These can be inherited by others
>>> unless changed, perhaps by a 'C' runtime library. Basically,
>>> the SIGSTOP handler executes pause() until the SIGCONT signal
>>> is received.
>>>
>>> Any delay in stopping is the time necessary for the signal to
>>> be delivered. It is possible that the section of code that
>>> contains the STOP/CONT handler was paged out and needs to be
>>> paged in before the signal can be delivered.
>>>
>>> You might quicken this up by installing your own handler for
>>> SIGSTOP and SIGCONT....
>>
>> I don't know what RTOSes you've been working with recently, but none of
>> the above is true for Linux.  I don't think it ever has been.
>>
>
> I don't even think it was true for anything. It's his usual way of
> saying things.
>

Nope, I thought he was talking about the terminal stopper/starter,
SIGTSTP used for X-ON and X-OFF. I thought he was sending that signal,
timing it, then restarting with SIGCONT. You can't restart or
even trap a SIGSTOP signal.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
