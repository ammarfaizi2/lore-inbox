Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271769AbRHUSAa>; Tue, 21 Aug 2001 14:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271770AbRHUSAU>; Tue, 21 Aug 2001 14:00:20 -0400
Received: from smtp-rt-11.wanadoo.fr ([193.252.19.62]:40433 "EHLO
	magnolia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S271769AbRHUSAJ>; Tue, 21 Aug 2001 14:00:09 -0400
Message-ID: <3B82A2C5.48E4DFC@wanadoo.fr>
Date: Tue, 21 Aug 2001 20:04:53 +0200
From: Pierre JUHEN <pierre.juhen@wanadoo.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: fr, French, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, mj@suse.cz, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Subject: Re: PROBLEM : PCI hotplug crashes with 2.4.9
In-Reply-To: <3B816617.F5C1CD24@wanadoo.fr> <20010820123625.A31374@kroah.com> <08d401c129ca$94ebd2a0$6800000a@brownell.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was a bit lazy, writing by memory : you are right the system says

"pcimodules is scanning more than 00:00.0"

but onluy this line and crashes. Under 2.4.6, it scans all the pci
adresses.

Renaming pcimodules to pcimodules- leads to " ** can't synthesize pci
hotplug events".

On my system, kudzu is started after hotplug, so the problem seems not
linked with that,
since it crashes even during boot, very early, just after fsck.




David Brownell a écrit :

> >     Only the
> > first line "pcimodules scanning 00:00.0" is displayed.
>
> Curious.  If anything, I'd expect it to say
> "pcimodules is scanning more than 00:00.0".
> (The last version I saw didn't have a way to
> scan for modules appropriate to a particular
> PCI slot, and the hotplug scripts warn about
> that limitation.)
>
> You might try renaming "pcimodules" to "pcimodules-"
> to see if that changes any interesting behavior.  I notice
> you're using RedHat with 7.1 and usb-uhci.  I seem to
> recall that Kudzu wanted to do some hotplug-ish things;
> they may not play well together yet.
>
> - Dave

