Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSANSvY>; Mon, 14 Jan 2002 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSANSu4>; Mon, 14 Jan 2002 13:50:56 -0500
Received: from [208.29.163.248] ([208.29.163.248]:4288 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S288830AbSANSug>; Mon, 14 Jan 2002 13:50:36 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Mon, 14 Jan 2002 10:50:20 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114131050.E14747@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0201141045130.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can see a couple reasons for building a kernel without useing modules.

1. security, if you don't need any modules you can disable modules entirly
and then it's impossible to add a module without patching the kernel first
(the module load system calls aren't there)

2. speed, there was a discussion a few weeks ago pointing out that there
is some overhead for useing modules (far calls need to be used just in
case becouse the system can't know where the module will be located IIRC)

3. simplicity in building kernels for other machines. with a monolithic
kernel you have one file to move (and a bootloader to run) with modules
you have to move quite a few more files.

modules are good for distros and for machines that have to worry about
hotpluged equipment (but even that is less nessasary then it used to be)
but for servers that don't change their hardware they aren't nessasary,
why should they have to deal with them?

David Lang




On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Date: Mon, 14 Jan 2002 13:10:50 -0500
> From: Eric S. Raymond <esr@thyrsus.com>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Mr. James W. Laferriere <babydr@baby-dragons.com>,
>      Giacomo Catenazzi <cate@debian.org>,
>      Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: Hardwired drivers are going away?
>
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > For 2.5 if things go to plan there will be no such thing as a "compiled in"
> > driver. They simply are not needed with initramfs holding what were once the
> > "compiled in" modules.
>
> This is something of a bombshell.  Not necessarily a bad one, but...
>
> Alan, do you have *any* *freakin'* *idea* how much more complicated
> the CML2 deduction engine had to be because the basic logical entity
> was a tristate rather than a bool?  If this plan goes through, I'm
> going to be able to drop out at least 20% of the code, with most of
> that 20% being in the nasty complicated bits where the maintainability
> improvement will be greatest.  And I can get rid of the nasty "vitality"
> flag, which probably the worst wart on the language.
>
> Yowza...so how soon is this supposed to happen?
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> Government should be weak, amateurish and ridiculous. At present, it
> fulfills only a third of the role.	-- Edward Abbey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
