Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVBXRJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVBXRJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVBXRJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:09:04 -0500
Received: from alog0383.analogic.com ([208.224.222.159]:17280 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262423AbVBXRI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:08:27 -0500
Date: Thu, 24 Feb 2005 12:07:32 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: folkert@vanheusden.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: accept() fails with EINTER
In-Reply-To: <20050224164620.GD5138@vanheusden.com>
Message-ID: <Pine.LNX.4.61.0502241156090.17635@chaos.analogic.com>
References: <Pine.LNX.4.61.0502231009380.5342@chaos.analogic.com>
 <20050224164620.GD5138@vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 folkert@vanheusden.com wrote:

>> Trying to run an old server with a new kernel. A connection
>> fails with "interrupted system call" as soon as a client
>> attempts to connect. A trap in the code to continue
>> works, but subsequent send() and recv() calls fail in
>> the same way.
>
> Weren't you supposed to just 'try again' when receiving EINTR (or
> EAGAIN)?
>

Absolutely. However it's an old server that used to work with
2.4.22 and before. I don't want to have to rewrite everything
and.... Why should send() recv() read() write(), etc. always
get an EINTR everytime something uses them?  It doesn't happen
on other systems.

I think that something is supposed to be masked OFF that
isn't being masked OFF

>
> Folkert van Heusden
>
> Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
> +------------------------------------------------------------------+
> |UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
> |a try, it brings monitoring logfiles to a different level! See    |
> |http://vanheusden.com/multitail/features.html for a feature list. |
> +------------------------------------------= www.unixsoftware.nl =-+
> Phone: +31-6-41278122, PGP-key: 1F28D8AE
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
