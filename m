Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSEIRt4>; Thu, 9 May 2002 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSEIRtz>; Thu, 9 May 2002 13:49:55 -0400
Received: from imr2.ericy.com ([198.24.6.3]:58774 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id <S314056AbSEIRty>;
	Thu, 9 May 2002 13:49:54 -0400
Message-ID: <3CDA61CA.498991DF@edb.ericsson.se>
Date: Thu, 09 May 2002 14:47:22 +0300
From: Christian Burger <christian.burger@edb.ericsson.se>
Reply-To: christian.burger@edb.ericsson.se
Organization: Ericsson
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: fonts corruption with 3dfx drm module
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen a much more serious problem which seems to be related to this:
I have AMD Athlon K7 650MHz, Via chipset, Voodoo5 5500AGP, MTTR enabled.
What is happening here is that when switching back from init 5 to init 3 for
instance, the system hangs completely and a blinking character appears in a
black screen. There's no other way other than to power cycle the system. It
seems to be a kernel panic.
Kernel version is 2.4.18, and it happens with or without DRM support, with and
without FB support. There's no way I can have this version of the kernel to work
here.
Thanks, 

	Christian Burger


On Mon, Jan 28, 2002 at 04:12:34PM +0200, Zwane Mwaikambo wrote:

> On Mon, 28 Jan 2002, Zwane Mwaikambo wrote:
> 
> > Do you guys have CONFIG_MTRR and/or CONFIG_FB_VESA enabled? Also which 
> > motherboard chipset?

MTRR, of course (do you like 2D and even 3D hardware accelerated without 
MTRR?), FB, no, chipset is a AMD 750 (Irongate C4), using X 4.1.99.1 DRI CVS.

I am with the DRI devel team and saw it occasionally with XFree86 DRI CVS 
trunk and the latest mesa-4-0-branch. At that time I had FB enabled as I 
remember right.

The current DRI stuff is "only" missing the latest XFree86 4.2.0 release 2D 
code. Update is under way.

I can _NOT_ see it without FB and currently running 
2.4.18-pre7-J6-VM-23-preempt-lock.
 
/home/nuetzel> cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 128MB: write-back, count=1
reg02: base=0xec103000 (3777MB), size=   4KB: write-combining, count=1
reg03: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=2

Voodoo5 5500 AGP.

Regards,
        Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
