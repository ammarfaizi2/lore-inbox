Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262493AbTCILMX>; Sun, 9 Mar 2003 06:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262494AbTCILMW>; Sun, 9 Mar 2003 06:12:22 -0500
Received: from mid-1.inet.it ([213.92.5.18]:63380 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id <S262493AbTCILMV> convert rfc822-to-8bit;
	Sun, 9 Mar 2003 06:12:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: thunder7@xs4all.nl, Michal Semler <cijoml@volny.cz>
Subject: Re: very buggy 3DFx framebuffer support!!! :(
Date: Sun, 9 Mar 2003 12:22:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, vandrove@vc.cvut.cz
References: <E18rmiu-0000ew-00@notas> <20030309055453.GA9064@middle.of.nowhere>
In-Reply-To: <20030309055453.GA9064@middle.of.nowhere>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030309111221Z262493-25575+27533@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 06:54, Jurriaan wrote:
> From: Michal Semler <cijoml@volny.cz>
> Date: Sat, Mar 08, 2003 at 11:23:18PM +0100
>
> > Hello,
> >
> > I found out very buggy 3DFx framebuffer support :(
> >
> > when I select nothing when console bootings, I got white background under
> > Tux, rolling up with black background of text. Then everything under Tux
> > has black background and white text, but there, where is tux icon
> > everything on the right side of the icon has still white background
> >
> > when I select in lilo
> > append="video=tdfx:1024x768-24@75"
> >
> > my console gets screws up and I can't see anything under it. X windows
> > but works.
> >
> > When I boot computer without append and then call it with fbset -a
> > 1024x768-75 things are the same ;( and I still can select Xwindows with
> > alt+f7
> >
> > Please can anybody fix this?
> >
> > Linux 2.4.20 vanilla, gcc 3.0.4, Debian woody 3.0r1, 3DFx card, P3 733
> > Coppermine
>
> What 3dfx card? Output in log-files? Dmesg-output? output of 'dmesg' ?
>
> Jurriaan

I have the same problem when I use the "tdfxfb" driver, my configuration is:
Linux 2.4.20, gcc 2.95.4, Debian woody 3.0, AMD Duron 750 and...
	3dfx Voodoo Banshee (16 Mb)

$ dmesg | grep "tdfx"
tdfxfb: reserving 1024 bytes for the hwcursor at c97ff000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0

$ dmesg | grep "fb"
fb: Banshee memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at c97ff000
fb0: 3Dfx Banshee frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device

I don't see any error... 

	Paolo

