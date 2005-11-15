Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVKOXUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVKOXUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVKOXUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:20:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15620 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932554AbVKOXUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:20:19 -0500
Date: Wed, 16 Nov 2005 00:20:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051115232006.GK5735@stusta.de>
References: <43795575.9010904@wolfmountaingroup.com> <20051115050658.GA13660@redhat.com> <43797E05.5090107@wolfmountaingroup.com> <17273.34218.334118.264701@cse.unsw.edu.au> <4379846E.2070006@wolfmountaingroup.com> <20051115141851.18c2c276.grundig@teleline.es> <1132061045.2822.20.camel@laptopd505.fenrus.org> <dld3cs$1sh$1@sea.gmane.org> <20051115185543.GI5735@stusta.de> <20051115222656.8D11816F4D9@smtp.lmc.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115222656.8D11816F4D9@smtp.lmc.cs.sunysb.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 05:27:10PM -0500, Giridhar Pemmasani wrote:
> On Tue, 15 Nov 2005 19:55:43 +0100, Adrian Bunk <bunk@stusta.de> said:
> 
>   Adrian> And the fact that it might force people to help with the
>   Adrian> development or at least use open source drivers for their
>   Adrian> hardware instead of binary-only Windows drivers isn't
>   Adrian> exactly a disadvantage for the development of Linux.
> 
> IMO, this is at best only one side of the coin: Many people that ask
> for help with ndiswrapper seem to be newbies that have just begun
> using Linux. Most of these people can't/won't help with development of
> native drivers. On the other hand, ndiswrapper can be used in reverse
> engineering. I know of at least two such cases. So thinking
> ndiswrapper as a scourge that hinders development (I am exaggerating a
> bit here, but it has been suggested so by certain people more than
> once on lkml) is not correct. Informed users, especially those that
> follow lkml, are more interested in helping development of native
> drivers and would chose to use native drivers if possible. Leaving
> other end users high and dry without wireless support until such
> drivers are available is not necessarily helpful for development of
> open source drivers.

My impression is more that there is a big demand for ndiswrapper (look 
e.g. at your download numbers below and some statements in this thread) 
while support for the people developing open source drivers isn't that 
big.

> In essence, ndiswrapper is for those chipsets that have no open source
> drivers until one can be developed.

In essency, ndiswrapper is a good excuse for hardware vendors who do not 
want to support the development of open source drivers, because they can 
always tell their costumers "Our hardware is supported by Linux through 
the open source ndiswrapper module".

> This issue raises a concern for me as developer of ndiswrapper. I
> perceive that some kernel developers have strong opinions against
> ndiswrapper. I see ndiswrapper as contributing my 2 cents - I have no
> vested interests in ndiswrapper, although it will be sad to see lot of
> effort and time put into ndiswrapper go waste. However, I believe

My personal opinion is that the ability to use unmodified binary-only 
Windows drivers under Linux is really a cool project - and this is meant 
in a 100% positive sense.

But a side effect is a worse open source support for the hardware in 
question.

> there is a need for such a project: There is a company (Linuxant) that
> sells a product similar to ndiswrapper, ndisulator, which is similar
> to ndiswrapper, is merged into FreeBSD kernel, and ndiswrapper itself
> has been downloaded more than half a million times from Sourceforge
> alone. And not all native drivers support all the features that users
> need, e.g., WPA, whereas ndiswrapper supports all features provided by
> vendor for Windows driver. And there are chipsets for which open
> source drivers may not be available ever since they are rare. And if
> it takes many months/years to develop a stable open source driver,
> users need some way of using their hardware until then. And so on. I
> am not trying to argue in favor of ndiswrapper at the cost of open
> source drivers, but that there is a genuine need for such a project,
> at least for now.

As I tried to express above, both current end users and hardware vendors 
might like ndiswrapper, but as a side effect there are less and/or worse 
open source drivers.

It partially boils down to the question whether it's better for Linux to 
get as much hardware supported now no matter how, or whether it's better 
to have less hardware supported with good open source drivers and with 
end users putting pressure on hardware vendors to help people developing 
open source drivers.

And there's also the side effect that a poorly written Windows driver 
might crash the Linux kernel. Many end users will attribute such a crash 
to the Linux kernel harming the reputation of Linux as being stable.

> This is neither a complaint nor a plea; if option to chose 8k stacks
> is dropped in the kernel, so be it. If I find time to provide support
> for private 8k stacks within ndiswrapper, I will do that, so that if
> this patch makes into kernel, users who need some way of using the
> wireless cards can do so, for now.
>...

It's not the main purpose of my patch to break ndiswrapper, that is a 
collateral damage - but IMHO a positive one.

And we are talking about open source.

You are free to solve the stack problem in ndiswrapper (which might 
already be requierd for some drivers that aren't even happy with the 
current stack limit), or you can tell people to undo my patch or 
whatever.

> Giri

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

