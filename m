Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287924AbSAVHFz>; Tue, 22 Jan 2002 02:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288114AbSAVHFq>; Tue, 22 Jan 2002 02:05:46 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:57404 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S287924AbSAVHFf>; Tue, 22 Jan 2002 02:05:35 -0500
Date: Tue, 22 Jan 2002 09:05:18 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "David S. Miller" <davem@redhat.com>
Cc: andrea@suse.de, alan@redhat.com, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, ripperda@nvidia.com, drobbins@gentoo.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122070517.GK135220@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"David S. Miller" <davem@redhat.com>, andrea@suse.de,
	alan@redhat.com, linux-kernel@vger.kernel.org, akpm@zip.com.au,
	ripperda@nvidia.com, drobbins@gentoo.org
In-Reply-To: <3C4C5B26.3A8512EF@zip.com.au> <20020121.142320.123999571.davem@redhat.com> <20020122013909.N8292@athlon.random> <20020121.170822.32749723.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020121.170822.32749723.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller said:
>
> The funny part is, if this published errata is the problem, it cannot be a
> problem under Linux since we never invalidate 4MB pages.  We create them
> at boot time and they never change after that.

and:
>  From: Arjan van de Ven <arjanv@redhat.com>
>  > Well we don't know what nvidia's kernel module is doing.....                 
>                                                                                 
> I know it isn't using large pages, that is for sure.

and:
> I think this is all "just so happens" personally, and all the that
> turning off the large pages really does is change the timings so that
> whatever bug is really present simply becomes a heisenbug.

Andrea Arcangeli <andrea@suse.de> said:
> My same wondering, however I wasn't sure how much the timing could
> really change to make the kernel bugs trigger.

Alan Cox said:
> That problem shouldnt be hitting Linux x86. I don't know about the Nvidia
> module but the base kernel shouldnt hit an invlpg on 4Mb pages


Here's what Ripperda of nVidia (I imagine this is the same "Terrence
Ripperda of NVIDIA" mentioned at http://www.gentoo.org/) said on nvidia @
#irc.openprojects.net:

*** ripperda (~ripperda@z06.nvidia.com) has joined channel #nvidia
<Primer> ripperda: my man!
<Primer> major props for reporting the athlon bug
<ripperda> hey primer
<ripperda> thanks, hopefully we can get athlons a lot more stable under the
drivers now
<ripperda> I feel bad I screwed the pooch and didn't get it figured out
quicker
<Thunderbird> who discovered the bug after all?
<Primer> Thunderbird: AMD, back in Sept. 2000
<Primer> :P
<ripperda> one of our main windows kernel developers here, over a year ago
<Primer> except they forgot to tell us
<Thunderbird> why did nobody publish it before then?
<ripperda> he mentioned it to me, but I was swamped with other things, tried
to see if it would affect us, but was still a little new to the kernel code
<Russ|werk> hey ripperda
<Russ|werk> ripperda: is the fix going to cause a release?
<ripperda> this athlon bug can't be fixed in our code, that's a kernel issue

So clearly either nvidia driver uses large paging or there appears to be
some great misunderstanding.

Also, drobbins at http://www.gentoo.org goes on to say:

"I informed kernel hacker Andrew Morton of the issue; he put me in touch
with Alan Cox.  Alan is going to try to add some kind of Athlon/AGP CPU bug
detection code to the kernel so that it will be able to auto-downgrade to 4K
pages when necessary."

Another case of miscommunication?

I sincerely hope you guys can sort this out...


-- v --

v@iki.fi
