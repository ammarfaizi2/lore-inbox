Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276335AbRJPOth>; Tue, 16 Oct 2001 10:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276337AbRJPOt1>; Tue, 16 Oct 2001 10:49:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:1545 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S276335AbRJPOtY>;
	Tue, 16 Oct 2001 10:49:24 -0400
Message-ID: <3BCC4734.913A8852@evision-ventures.com>
Date: Tue, 16 Oct 2001 16:41:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: Anuradha Ratnaweera <anuradha@gnu.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: VM
In-Reply-To: <Pine.LNX.4.33.0110161503300.17096-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> 
> I used bot VM in many situations and with many different HWs.
> I came to the conclusion that  actually  none of the two VMs is suitable
> for every use.
> aa VM deals better because of its design on my web servers, with a non
> eccessive amount of memory, and with mysql and oracle databases.
> 
> When I talk of AA vm i mean the 2.4.13preXaa1 versions.
> 
> Unfortunatelly I have also found a problem with
> some situations when the VM is higly stressed, but Andrea was very kind to
> this report, and now I hope it has gone away (will test this afternoon).
> 
> aa VM was also good with dualAthlon servers used for montecarlo
> simulations, but also here, VM was not really stressed, and the system has
> just 1 GB of RAM.
> 
> Rik VM in its later version is dealing better with Ultrasparc64
> quadriprocessor with 4 GB RAM. But in this case we are talking of very
> very stressed system, with hundreds of huge processes, doing a lot of swap
> in/out, and with 8 GB swap space.
> I am just sorry that i have access to this machine just from times to
> times, when a critical problem appears, but this is a production server.
> 
> The reason is the aa VM is more predictable, but rik's one actually
> seems to be smarter under very very stressed situations.
> 
> I do not care which VM is simpler, nor which is faster. I loock for
> predictability, since this is the most important thing on the servers I am
> administering. Under a special situation I need something maybe less
> predictable, but smarter to manage a stressed system.

OK so let me bite now... If you look for predictability, then see:

Rik's page aging mechanism based VM went in short before 2.4.0 time.
Several months ago... Conceptually it was supposed to be a clone of
FreeBSD's memmory management system. However Rik overdesigned it
entierly. He inventen useless and far too many "tuning knobs".
And everybody should known that optimizations get really hard with
more then very few parameters. (Becouse even the math behind it get's
trully
complicated ;-) The situation until recently was
entierly inacceptable becouse the inadequacies of the VM where
blatant. No ORACLE running, no X session on lower memmory and so on and
so
on. Maybe by now he reached some level of stability, (by trail and error
if
you ask me), but please see that it only took 2 kernel release cycles 
until Andreas efforts showed fruits at least comparable (and in my
oppinnion much suprerior) to what can be currently seen in the ac series
in regard
of memmory management. This still holds even if you take into account
that Linus and AA both went a bit wild with the IO system redesign. 

Don't missunderstand me please I appreciate those changes as well
becouse
I see that they are finally addressing block device handling problems
I'm complaining about since 2 years regularly here and which are
artefact from the youngest days of Linux.

So if you look at this history and see what's going on the conculsion is
easly found: The chances are indeed very high that the behaviour of the
Linus tree is much more predictable ;-). (In the VM context of course.)
