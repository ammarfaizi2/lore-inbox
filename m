Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271286AbRHOQr1>; Wed, 15 Aug 2001 12:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271285AbRHOQrR>; Wed, 15 Aug 2001 12:47:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48501 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271286AbRHOQrH>; Wed, 15 Aug 2001 12:47:07 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
	<9kuid8$q57$1@cesium.transmeta.com>
	<m1n157rrpk.fsf@frodo.biederman.org>
	<9l2p9e$89h$1@cesium.transmeta.com>
	<m166brqeyc.fsf@frodo.biederman.org> <3B79550F.4030800@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Aug 2001 10:40:16 -0600
In-Reply-To: <3B79550F.4030800@zytor.com>
Message-ID: <m1ofphp98v.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> The point is that this belongs in the kernel image, so that it can be evolved,
> not in the boot loaders, where it becomes static.  These kinds of things will in
> 
> practice change too quickly to be frozen into boot loaders.

In principle I agree.  But until I have thought out all of the angles
I'll play with just about every idea.

I will say though that having a 32bit entry point in a bootloader is
fully reasonable as, if you are doing anything more than zImage the
bootloader needs to switch into protected mode anyway.  However having
a the ability to switch back into realmode to do BIOS calls is also
reasonable. The interesting case there is loadlin.

But I fully agree that bootloaders should be as simple as possible
with respect to the kernel.  But I also have a major issue with 
the fact that rdev only works on x86.  And even with linuxBIOS around
it would be nice to compile a kernel that is x86-generic.  That is one
of the neater ideas of the alpha port.  I know on the ppc port it
splits up per bootloader.  I don't have any problems with compiling
for a specific environment but I don't want to make it mandatory.

Eric
