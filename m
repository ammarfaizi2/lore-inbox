Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSLMVMX>; Fri, 13 Dec 2002 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSLMVMX>; Fri, 13 Dec 2002 16:12:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11023 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265409AbSLMVMV>;
	Fri, 13 Dec 2002 16:12:21 -0500
Message-ID: <3DFA4ED1.7090209@pobox.com>
Date: Fri, 13 Dec 2002 16:19:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Donald Becker <becker@scyld.com>, "David S. Miller" <davem@redhat.com>,
       Roger Luethi <rl@hellgate.ch>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Networking/Becker et al [was Re: pci-skeleton duplex check]
References: <20021213092229.D9973@work.bitmover.com>
In-Reply-To: <20021213092229.D9973@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Don is a careful, thoughtful guy.  He is quite conservative when it comes
> to programming.  His style most closely matches the Sun kernel style of
> development; it does not match the Linux style at all.  The Linux style
> is a lot more free wheeling, stuff changes a lot and the kernel team
> depends heavily on the fact that it is has this vast army of free testers.
> Without that army, I shudder to think what things would be like, I do not
> think the current development style would work anywhere near as well.
> 
> But it does work, and it violates a lot of engineering disciplines that
> old farts, like me and Don, respect.  I've learned to live with it, even
> respect the fact that the Linux team does so well.  Don is having a much
> tougher time.  He really wants the Linux team to work more like he works
> and the Linux team doesn't want to do that at all, they point at their
> success and believe that their development style is part of that success.

This meshes with what I've observed, too...

I'm not sure which is the bigger issue, Don's devel style versus Linux 
devel style, or use of kernel APIs, but both I think cut to the core of 
the differences in this situation.


> It is worth putting on the record that Don has done a lot for the Linux
> effort, a huge amount, in fact.  Without Don, Linux would be dramatically
> less far along than it is.  I've been here since before it had networking
> and it really took off when Don started writing drivers.

I give him a lot of credit too, though it's often in the way of trying 
to apply lessons learned from him to current net drivers and such.


> It's also pointing out that I think he's right about the networking
> regressions, suspend/resume on laptops used to work and now the network
> is almost always hosed after I do that.

suspend/resume in Linux has always been a hack, and will continue to be 
until the 2.5.x sysfs/device model is fully fleshed out.  Specifically 
for 2.4.x, let me know if your net driver doesn't suspend/resume 
correctly.  The cases I've tested work fine.  Make sure your distro is 
properly calling the /sbin/hotplug agent when suspend/resume occurs though.


> I doubt that either side is likely to change their view.  But, the real
> point is how to we get Don's brain engaged on the kernel networking
> drivers?  A few thoughts:
> 
>     a) Don is going to have to accept that the Linux kernel approach is
>        the way it is.  Sitting on the sidelines and whining is not going
>        to change how the kernel is developed.  Either get with the 
>        program or not, but don't sit there and complain but refuse
>        to work the way the rest of the people work.

indeed... central problem


>     b) The kernel folks need to listen to Don more.  Draw him into the
>        conversations about interface changes, try and extract the 
>        knowledge he has, it's worth it.  Not doing so just means you
>        are wasting time.

I try to do this, and I can point to many specific instances in the past 
when he's been very helpful.

I would love to get Don more involved in interface discussions though... 
typically where he pops up [where I see him] is more in the area of 
hardware experience and knowledge than interface discussions.



>     c) Don needs to kill those mailing lists he maintains or merge them
>        with the appropriate kernel lists.  That is a big part of the
>        problem, the interesting stuff seems to be happening over in 
>        Don's part of the world and the mainstream kernel team isn't
>        aware of it.

This is really a matter of getting his driver changes into the kernel, 
too...  Some mailing list users [not me] would probably complain about 
seeing support traffic for drivers that are not in the kernel.


>     d) Beer.  More beer.  Much more beer and some face time.  If there
>        is a tech conference coming up, I think we should get Don to 
>        come and give him the first lifetime achievement award for
>        Linux kernel development.  Then shove him and the other network
>        hackers into a room with a keg and not let them out until they
>        are smiling.  BitMover will kick in some money towards this if
>        needed.

mmmmmmm, beer :)


