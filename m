Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265239AbUD3TgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbUD3TgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUD3TgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:36:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17281 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265239AbUD3Tey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:34:54 -0400
Date: Fri, 30 Apr 2004 15:37:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Keith D Burgess Jr <kburgessjr@mailblocks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <kburgessjr-0xCluARlZpTw8H14dt1fTkTpb7aWgyA@mailblocks.com>
Message-ID: <Pine.LNX.4.53.0404301534260.4532@chaos>
References: <kburgessjr-0xCluARlZpTw8H14dt1fTkTpb7aWgyA@mailblocks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Keith D Burgess Jr wrote:

> A couple days ago when I stumbled onto this discussion, I was prompted
> to at least post an opinion from a user perspective. Having followed
> along since then, I am beginning to wonder why I am so interested in
> the Linux community in the first place. I have to admit, my chin is
> still on the floor having read some of the personal attacks directed
> towards Marc. Why, for some, has this become a personal issue and not a
> technical one? I think Marc summed it up best (a few times) by saying:
>
> >> I repeat, the \0 is purely a technical workaround, done without any
> mischievous intent.
>
> Can't we respect this as his explanation and move on so these efforts
> can be better directed towards improving the kernel? Hell - Marc has
> alot of work to-do in order for driverloader to be compatible with 4K
> stacks ;)  (BTW I have no idea how you can support Fedora but it is
> appreciated.) There seems to be a couple posters here that understand
> why this workaround was done and agree that there needs to be a better
> way than seeing repeated "tainted" messages. In my opinion, this is the
> perspective that should have been taken from the start. Or at least
> once the list realized the intent and received Marc's appologies.
>
> P.S. Thanks to those who offered your opinions in agreement with mine
> via email but not on the list.
>
> Respectfully,
> Keith
>
>

Well it works like this:

Presume you devoted a lot of time and effort to writing
a driver for a popular SCSI Disk controller.

All of the sudden, you get a rash of complaints that
your driver is crashing systems, trashing data or otherwise
creating havoc.

So, you spend a few hundred hours of your time going over
the code line-by-line and you can't find anything wrong.
Also, you keep getting hate mail from persons who claim
that you have destroyed a lifetime of work because your
controller trashed their data.

Eventually you find that some software for a "@!&*($^@*(%"
screen card is trashing your code. That's the reason why
you've been getting blamed for destroying everybody's
data. You can't look at the software for that screen-card
because some idiot in Marketing thought that the 200 lines
of Linux-trashing software was "proprietary".

So, you make sure that if anybody in the future writes
such trash or potential trash and loads it into the kernel
where there is no protection from it, it is appropriately
marked.

Then, when somebody sends you a crash-dump and it is marked
"Tainted", you can tell them to unload whatever drivers are
causing that effect and then try your driver again. This
will save you untold weeks of agony in the future.

Now we have somebody who decides to "beat the system", to
allow tainted modules without them being displayed. Of
course the persons who have wasted a significant portion
of their lives looking for bugs that were caused by
secret drivers, will get a might bit angry.

Everybody has a right to load any kind of manure they
want into their own copy of the kernel. They don't have
any right to subject innocent module-writers to the
poison of a module they can't inspect.

Also, a module that is loaded into the kernel can
do __anything__. It can inspect the contents of your
hard disks and send whatever it wants to some unfriendly
company (Like Back-web). It can send information about
the letters you write and the Web Pages you frequent
(like Carnivore). It can use your CPU resources to
compile a security-liability index about your life-
style and send the results to the NSA (like Magic Lantern).

Certainly you should want to inspect anything that
is running on your system. This means that you need
to be able to inspect the source-code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


