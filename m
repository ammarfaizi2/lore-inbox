Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129549AbQKSPCm>; Sun, 19 Nov 2000 10:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbQKSPCW>; Sun, 19 Nov 2000 10:02:22 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:33938 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129549AbQKSPCP>; Sun, 19 Nov 2000 10:02:15 -0500
From: David Lang <david.lang@digitalinsight.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 19 Nov 2000 07:16:52 -0800 (PST)
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <slrn91fjfh.dta.kraxel@bogomips.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.21.0011190707340.22457-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

there is a rootkit kernel module out there that, if loaded onto your
system, can make it almost impossible to detect that your system has been
compramised. with module support disabled this isn't possible.

if you have dynamic hardware, then yes it's nice to be able to update
modules and change them on the fly. However for firewalls and routers they
have static configuration and no need to have modules on them (not that
the bttv driver that started this is needed on a router :-)

I frequently build kernels on systems other then the one that will
eventually run it. I like to enable only the fetures needed on the
destination machine. I find it easier to compile a monlithic kernel and
move the one file around then to compile a kernel and modules and move
that set of files around from machine to machine. And no, I can't get the
same result from useing the same kernel loading different modules on each
machine, different CPUs require different optmisations.

the point is that while modules are nice at times and every distribution
ships with modules installed, there are very legitimate reasons why some
people may choose not to use them. The fact that third party binary-only
modules require something doesn't have any weight on any other kernel
decisions, so the fact that they need modules to be enabled shouldn't be
used as a precident to say that other kernel features can be made
module-only.

David Lang

On 19 Nov 2000 kraxel@bytesex.org wrote:

> Date: 19 Nov 2000 12:56:17 GMT
> From: kraxel@bytesex.org
> To: linux-kernel@vger.kernel.org
> Newsgroups: lists.linux.kernel
> Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
> 
> > > Why?  What is the point in compiling bttv statically into the kernel?
> > > Unlike filesystems/ide/scsi/... you don't need it to get the box up.
> > > No problem to compile the driver as module and configure it with
> > > /etc/modules.conf ...
> > 
> > Huh?
> > 
> > Some systems are built without module support for numerous reasons.  I don't
> > need 50% of the entire kernel to get the box up, but I surely use it and I
> > don't want 100 modules loaded.
> 
> Why not?  /me has nearly everything compiled as modules.
> 
> > There is an introduced security weakness by using kernels.
> 
> ???  Guess you mean "by using modules"?  Which weakness?  Other than
> bugs?  I don't see bugs like the recent modprobe oops as major problem.
> They happen (everythere), they get fixed.
> 
> > So..what is the point in making it modular?
> 
> It's much more flexible.
> 
> You can reconfigure/update the driver without recompiling the kernel
> and without rebooting.  If the driver needs some tweaks to make it
> work with your hardware you can update /etc/modules.conf and reload
> the modules with the new options.  If you have found a working
> configuration, you can simply leave it as is.
> 
> 
> Distributions ship with modularized kernels.  Most external drivers
> can't be compiled into the kernel (alsa, lirc, vmware, ...).  Sometimes
> I find it very useful to be able to switch drivers on the fly:
> 
>  * rmmod ide-cd; modprobe ide-scsi; modprobe sr_mod (for burning CD's)
>  * /etc/rc.d/init.d/network stop; rmmod de4x5; modprobe tulip;
>    /etc/rc.d/init.d/network start (tulip manages it to drive the card
>    full-duplex, de4x5 doesn't).
> 
> 
> And I don't like fact that I have to add one more function for every
> cmd line option (looks like this from Werner's patch, hav'nt checked).
> 
> Some generic way to make module args available as kernel args too
> would be nice.  Or at least some simple one-liner I could put next to
> the MODULE_PARM() macro...
> 
> > --------------E48A413646B728A179A7D2FC
> > Content-Type: text/x-vcard; charset=us-ascii;
> >  name="david.vcf"
> 
> Please turn this off.
> 
>   Gerd
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.2

iQEVAwUBOhfu6z7msCGEppcbAQEDOgf+ICEoB72rzVp0z/9gzalz0ukl+M99BGdD
Q/ssFXB7+OHE+kg7U301gQOxWrcK7gi4wcOT5LYj1iW1c6MNpnA0fB+VZtWGgQ8a
l6/oZf+KXyZcp+8lrKgQVU3FYM8X0o1jhjwANSfveY0Ldy+3sFpH+QKW3p6lCNrv
ayd/GtE6EG9bhEFnLvC7FekWlJuIOmK6T5Sup5T8Z7u8mR0JEU6UjjW89nsYeCAo
l+B5fCPtXM3RPyxqJKgMW9ygMFldb0a6AijmohdFid3QTWpCedxciYzO3cZKP+oU
Cd0uq9dDoMTxA4y3B1oofMjb1VGh0jXDR0F/5ny9GX29JE/96zYWtg==
=65wf
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
