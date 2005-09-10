Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVIJJDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVIJJDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 05:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVIJJDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 05:03:19 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:53426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750711AbVIJJDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 05:03:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=iZhj23eOR2ddnJtFT8yUPW5U95gehj2kybVLqGifmh4S1rKGWbgQ6S2VnqwT1OqgVnoXLrp1DpRm/2b7Hy/BnQRcfvbe7uR7eFYeMTguvUKBa3LvPn+GTzpW+8uIEa8L72JzHlsic8600xUs5dq9ig1mSYTfLd+E2pn0ZPXkjqc=
Message-ID: <4322A160.1060809@gmail.com>
Date: Sat, 10 Sep 2005 11:03:28 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050823)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
References: <20050909214542.GA29200@kroah.com>
In-Reply-To: <20050909214542.GA29200@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

just for understanding the problem right. Some questions.
Greg KH schrieb:

>Here are the same "delete devfs" patches that I submitted for 2.6.12.
>It rips out all of devfs from the kernel and ends up saving a lot of
>space.  Since 2.6.13 came out, I have seen no complaints about the fact
>that devfs was not able to be enabled anymore, and in fact, a lot of
>different subsystems have already been deleting devfs support for a
>while now, with apparently no complaints (due to the lack of users.)
>  
>
How could users really say/complain what brakage they have, in fact they
don't even know the relationship between all that
( e.g drivers -> devfs -> sysfs or other programs that rely on devfs)?

They aren't all developers to encrypt the "magic" bug reports/debug messages
spreading over the screen.

>I mean, how can you go wrong with deleting over 8000 lines of kernel
>code :)
>  
>
Right, it's a good/right work to remove dispensable code from kernel.
Even it makes it easier to maintain the code but what happen if
there is an "for now" an unresolved/unknown problem which no one notice 
so far?

Devfs is in for many years, why removing it in just some weeks?

>So, please pull from:
>
>Please pull from:
>	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
>or if master.kernel.org hasn't synced up yet:
>	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
>
>I've posted all of these patches before, but if people really want to look at them, they can be found at:
>	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
>
>Also, if people _really_ are in love with the idea of an in-kernel
>devfs, I have posted a patch that does this in about 300 lines of code,
>called ndevfs.  It is available in the archives if anyone wants to use
>that instead (it is quite easy to maintain that patch outside of the
>kernel tree, due to it only needing 3 hooks into the main kernel tree.)
>  
>
I think this is a bad solution because on the one hand you "force" to 
remove devfs due it's crappy
naming sheme and on the other hand offering to add such thing again 
which brakes ALSA and other. *confused*
Even if it has only 300 lines of code.

This is not consistent with the intention to remove devfs forever.
Either say "live with it or die" or leave it as it is.

>thanks,
>
>greg k-h
>  
>
Thanks for your patience Greg

Best regards

--
Michael Thonke
