Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVEEAeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVEEAeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 20:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEEAeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 20:34:00 -0400
Received: from alog0211.analogic.com ([208.224.220.226]:10216 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261979AbVEEAd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 20:33:57 -0400
Date: Wed, 4 May 2005 20:33:42 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
In-Reply-To: <20050504191604.GA29730@nevyn.them.org>
Message-ID: <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com>
References: <4279084C.9030908@free.fr> <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
 <20050504191604.GA29730@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Daniel Jacobowitz wrote:

> On Wed, May 04, 2005 at 02:16:24PM -0400, Richard B. Johnson wrote:
>> The kernel doesn't do SIGSTOP or SIGCONT. Within init, there is
>> a SIGSTOP and SIGCONT handler. These can be inherited by others
>> unless changed, perhaps by a 'C' runtime library. Basically,
>> the SIGSTOP handler executes pause() until the SIGCONT signal
>> is received.
>>
>> Any delay in stopping is the time necessary for the signal to
>> be delivered. It is possible that the section of code that
>> contains the STOP/CONT handler was paged out and needs to be
>> paged in before the signal can be delivered.
>>
>> You might quicken this up by installing your own handler for
>> SIGSTOP and SIGCONT....
>
> I don't know what RTOSes you've been working with recently, but none of
> the above is true for Linux.  I don't think it ever has been.
>
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
>

Grab a copy of your favorite init source. SIGSTOP and SIGCONT are
signals. They are handled by signal handlers, always have been
on Unix and Unix clones like Linux.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
