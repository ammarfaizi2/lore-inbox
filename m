Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSD2VVt>; Mon, 29 Apr 2002 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313022AbSD2VVs>; Mon, 29 Apr 2002 17:21:48 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:31502 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S313019AbSD2VVq>; Mon, 29 Apr 2002 17:21:46 -0400
Date: Mon, 29 Apr 2002 23:21:44 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Stephan Maciej <stephan@maciej.muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sony Vaio Laptop problems
Message-ID: <20020429212144.GB1205@arthur.ubicom.tudelft.nl>
In-Reply-To: <200204261728.39745.stephan@maciej.muc.de> <20020429002811.GB3108@arthur.ubicom.tudelft.nl> <200204291630.22969.stephan@maciej.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 04:30:22PM +0200, Stephan Maciej wrote:
> On Monday 29 April 2002 02:28, Erik Mouw wrote:
> > 1) Update the BIOS, my laptop shipped with an old version and a BIOS
> >    update fixed some keyboard related problems. (you need to boot into
> >    windows for this)
> 
> Can I do this with a DOS bootdisk? I remember that most of the Flash updates 
> require you to startup the computer in a real DOS environment, at least those 
> I have seen for my ASUS P5A and A7V boards.

With my Asus P5A board I could update the BIOS by downloading the FreeDOS
installation disk, ripping all install stuff from it, and putting the
flash utilities on it.

The stuff you download from Sony is a self extracting EXE file that
contains, the flash utility, the BIOS image, and a couple of batch
files to put format a system floppy and put copy the correct stuff on
it. How inconvenient. You might be able to pull the image out of the
EXE file, it might even work within DOSemu+FreeDOS or within Wine. I
didn't try it.

> Windows XP didn't live long on my system - I just booted it after I bought 
> that thingy, then I installed Linux on the whole disk. I can live with the 
> reboot problem, as long as I'd have to install XP or some other Microsoft 
> shit on it to fix it.

BIOS updates was one of the reasons I let the XP partition exist.
Another one was the Lattice CPLD design tools.

> > 2) Apply the latest ACPI patch.
> 
> I'll try. Is anyone interested in getting positive feedback? You?

I'd think the ACPI people are always interested in feedback, be it
positive or negative.

> > [...]
> > My FX505 doesn't need the sonypi driver. With APM I can suspend the
> > computer but the CPU fan won't turn off; with ACPI the CPU fan turns
> > off, but I can't suspend the computer. Anyway, the latest ACPI patch
> > makes it a lot more quiet.
> 
> That's right. With APM, I had the problem that the fan didn't turn on if it 
> wasn't on after a power-on. Twice, my machine went off because it overheated.

That's also fixed with the BIOS upgrade: it always turns the fan on in
APM mode.

> > [...]
> > Use the ALSA-0.9 series driver instead of the kernel driver.
> 
> I'll try that, too.

If you have 2.5.9, you already have ALSA. You might want to compile it
as modules, in my experience ALSA sometimes fails to initialise the
sound device, but works when loaded the second time.

> > > So, just for completeness, here's my system configuration:
> > >
> > > Mobile AMD Duron Processor, 1GHz
> > > 256MB RAM
> > > IDE hard disk and CD/DVD ROM
> >
> > You forgot to tell which kernel version you are currently using.
> > Anyway, linux-2.4.19-pre5 + acpi-20020329-2.4.18 works for me.
> 
> Umm, I really forgot that. I am currently using a vanilla 2.5.9 kernel and I 
> am quite happy with it.

Ehm, you really don't want to be using 2.5.9 if you care about your
data. I see too many IDE problems coming by on linux-kernel that I
currently don't trust IDE support at all. Better stay with 2.4.18+acpi
or 2.4.19-pre*+acpi and ALSA.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
