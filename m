Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFCOmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFCOmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFCOmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:42:32 -0400
Received: from alog0277.analogic.com ([208.224.222.53]:10705 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261291AbVFCOma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:42:30 -0400
Date: Fri, 3 Jun 2005 10:40:56 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Wakko Warner <wakko@animx.eu.org>
cc: Tomko <tomko@avantwave.com>, linux-kernel@vger.kernel.org
Subject: Re: question why need open /dev/console in init() when starting
 kernel
In-Reply-To: <20050603141504.GA14641@animx.eu.org>
Message-ID: <Pine.LNX.4.61.0506031031070.13982@chaos.analogic.com>
References: <42A00065.9060201@avantwave.com> <Pine.LNX.4.61.0506030629170.11487@chaos.analogic.com>
 <20050603141504.GA14641@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005, Wakko Warner wrote:

> Richard B. Johnson wrote:
>> For error messages (as well as it's the law)! Init needs a terminal.
>> Init is the 'father' of all future tasks and they need a default terminal
>> too.
>
> Is it at all possible that if /dev/console does not exist that the kernel
> can mknod it?
>

Yes. Your initial console can be NULL, set as a kernel command-line
parameter. You should really be using an initial RAM disk (initrd).
That gets mounted for boot, containing whatever is necessary to
properly start the system, then change to the file root (or not).
This is how hundreds of different embeded systems are started.

Execute-in-place, which I think you are trying with 'cpio' will
continue to give you problems because you can't test it except
by throwing it off-the-cliff to see if it flies. RAM-disk systems
can be tested, booting on any media (even a floppy).

> Would the code to do this be larger than 2 entries in a cpio archive (one
> for /dev directory and one for /dev/console char dev)?
>
> -- 
> Lab tests show that use of micro$oft causes cancer in lab animals

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
