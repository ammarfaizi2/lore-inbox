Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUJLUaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUJLUaa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJLUaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:30:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:13013 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267743AbUJLUa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:30:28 -0400
Message-ID: <416C3E85.3060801@suse.de>
Date: Tue, 12 Oct 2004 22:28:53 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ncunningham@linuxmail.org
Subject: Re: Totally broken PCI PM calls
References: <1097455528.25489.9.camel@gaston> <200410111959.53048.david-b@pacbell.net> <20041012085440.GB2292@elf.ucw.cz> <200410121128.33861.david-b@pacbell.net>
In-Reply-To: <200410121128.33861.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> This is with /sys/power/disk set up for "shutdown";
> the system didn't actually shut down, it restarted
> the CPU right after snapshotting.
> 
> Stopping tasks: ===================|
> Freeing 
> memory: ........................................................................................................|
> Freezing CPUs (at 0)...ok
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> Restarting CPUs...ok
> Restarting tasks... done
> eth0: Media Link On 10mbps half-duplex 

you have a swap partition?
swap enabled?

> To an file that was just added recently, making it more
> like the other file in that same directory.

recently?

>>and was not /sys expected to be "one file, 
>>one value"?
> 
> It is one value -- a set!  OK, the active member
> of that set is distinguished.  The power/state file
> could do the same thing (but the active state
> there would always be "on").

But then we would need another file which provides the information that
/sys/power/state provides now, namely what power states are available.


   Stefan
