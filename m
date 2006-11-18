Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756228AbWKRIDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbWKRIDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756240AbWKRIDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:03:33 -0500
Received: from raven.upol.cz ([158.194.120.4]:13226 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1756228AbWKRIDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:03:32 -0500
Date: Sat, 18 Nov 2006 08:10:24 +0000
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
Subject: reboot, not loop forever (Re: [PATCH 20/20] x86_64: Move CPU verification code to common file)
Message-ID: <20061118081024.GE14673@flower.upol.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com> <slrnelt6h7.dd3.olecom@flower.upol.cz> <20061118063802.GE30547@bingen.suse.de> <20061118070101.GA14673@flower.upol.cz> <455EAF54.5090500@zytor.com> <20061118072259.GC14673@flower.upol.cz> <455EB72B.1010103@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455EB72B.1010103@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 11:32:59PM -0800, H. Peter Anvin wrote:
> Oleg Verych wrote:
> >On Fri, Nov 17, 2006 at 10:59:32PM -0800, H. Peter Anvin wrote:
> >>Oleg Verych wrote:
> >>>It will burn CPU, until power cycle will be done (my AMD64 laptop and
> >>>Intel's amd64 destop PC require that). In case of reboot timeout (or
> >>>just reboot with jump to BIOS), i will just choose another image to boot
> >>>or will press F8 to have another boot device.
> >>>
> >>That's a fairly stupid argument, since it assumes operator intervention, 
> >>at which point you have access to the machine anyway.
> >
> >I would never call *power cycle* stupid, just because from physics
> >point of veiw.
> >
> >Example. I have my flower.upol.cz many kilometers far away from me.
> >I used to boot it from that flash (new hardware, sata problems, etc).
> >
> >When something goes wrong with rc kernel or power source, bum.
> >And i had to move my ass there, just to press reset. Because.
> 
> Yes, and you would have to do that to press F8 too.

That peace of code used in many places, thus, i've mentioned F8, if
wrong kernel on wrong computer was launched.

> >While i have "power on, on AC failures" in BIOS, *sometimes* flash
> >will not boot (i don't know why, maybe it's GRUB+flash-read,
> >or BIOS usb hdd implementation specific).
> 
> I was making the point that there is unattended recovery possible.  That 
> makes it a significant argument.  That a user on a laptop has to wait 
> four seconds pushing the power button is not.

As additional note to Andi and many of you, who will say, that it's
a couple of asm instructions, just send patch.

I'm see many kinds of reboot functions in include/linux/reboot.h.
There even reboot_fixup.h. Some of them may be copy/pasted in place of
that while(1) loop, who knows which exactly? What problems it may cause?

I used to write PC bootloaders with tasm, when i was a child
(10 years ago). Nothing major, ok with that.

But i bet, i will spot whitespace and tabification issues in files,
i will visit with emacs and eventually making patches with that. First
ever try with top Makefile failed, this makefile have something after
tabification, that Andrew Morton's makefile (from FC5) doesn't like.
Funny. Don't call me bureaucrat, but this is (my) mater of *not* being
kind of dumb.

> 	-hpa

Thanks.

--
-o--=O`C  info emacs : not found  /. .\ (is there any reason to live?)
 #oo'L O  info make  : not found      o (           R.I.P            )
<___=E M  man gcc    : not found    .-- (  Debian Operating System   )

