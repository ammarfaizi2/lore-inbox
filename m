Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSCXSJU>; Sun, 24 Mar 2002 13:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311718AbSCXSGd>; Sun, 24 Mar 2002 13:06:33 -0500
Received: from adsl-63-203-200-210.dsl.snfc21.pacbell.net ([63.203.200.210]:41865
	"EHLO hodog.wesecurethe.net") by vger.kernel.org with ESMTP
	id <S311710AbSCXSGT>; Sun, 24 Mar 2002 13:06:19 -0500
From: Change Ling <change@wesecurethe.net>
To: vda@port.imtp.ilyichevsk.odessa.ua,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: vesafb not working in later 2.4.x kernels?
Message-ID: <1016992719.3c9e13cf53cca@www.wesecurethe.net>
Date: Sun, 24 Mar 2002 09:58:39 -0800 (PST)
Cc: Change Ling <change@wesecurethe.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1016820299.3c9b724bd3515@www.wesecurethe.net> <200203241057.g2OAvrX18323@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.7
X-HoozYoDaddy: I AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess I jumped the gun, and have proven that vesafb support is still in the 
latest stable.  My bad.

I'm using LILO version 21.7-5 as a boot loader.  Much to my chagrin I was 
finally able to get vesafb support on a machine running a RedHat 7.2 default 
lilo version(can't get at that machine at the moment to obtain the version 
diff).

I'm using the above mentioned version of lilo specifically for graphical boot 
time splash screen support.

I now need to determine if this lilo version supports some other method of 
manipulating video modes.  Which I guess no longer belongs in this forum.

thanks,

William



Quoting Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>:

> On 22 March 2002 16:04, Change Ling wrote:
> > I have been trying to build the vesafb under the 2.4.18 kernel for use
> in
> > my work on the biatchux bootable cdrom distribution, but the frame
> buffer
> > never seems to initialize at boot with the vga=791 kernel argument.
> >
> > It is as though the Video select option isn't handling the kernel
> arg,
> > since vga=ask doesn't present my with a selection menu either.
> >
> > Has vesafb or Video_select support somehow been dropped in the
> latest
> > stable kernel???
> 
> It is working here in 2.4.18.
> 
> IIRC vga=XXX isn't a kernel option, it is handled by kernel loader.
> Kernel loader parse vga=xxx and pass it to real-mode part of kernel init
> 
> code. That code switch display to specified video mode via VESA before
> it
> enters 32-bit mode.
> 
> Since even vga=ask does not work for you it seems your kernel loader
> does not 
> handle vga=xxx parameter correctly. What loader do you use?
> --
> vda
> 
