Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbSAPTpQ>; Wed, 16 Jan 2002 14:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSAPTpB>; Wed, 16 Jan 2002 14:45:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:2066 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287478AbSAPToE>;
	Wed, 16 Jan 2002 14:44:04 -0500
Date: Wed, 16 Jan 2002 11:40:26 -0800
From: Greg KH <greg@kroah.com>
To: David Garfield <garfield@irving.iisd.sra.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020116194026.GD1964@kroah.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <20020115233437.GC29020@kroah.com> <15428.49056.652466.414438@irving.iisd.sra.com> <20020116000117.GD29020@kroah.com> <20020116202958.E18039@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116202958.E18039@devcon.net>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 19 Dec 2001 16:58:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 08:29:58PM +0100, Andreas Ferber wrote:
> 
> Hmm. AFAICS this also implies that one would have to put /all/ drivers
> for /any/ hardware possibly plugged in at boot time on the initramfs.
> Or will /sbin/hotplug provide the ability to just put requests it
> can't resolve with the modules on the initramfs into some sort of
> queue file, which is read by /sbin/coldplug (or whatever) later on in
> the boot process to load drivers for those from the real root fs?

No, I hadn't thought of doing this.  If someone wants to knock out a
patch, I'd be glad to take a look at it.

> > And this allows lots of horrible "boot over NFS" and other network
> > code/hacks in the kernel to be moved out of kernel space, and into
> > userspace, where it really belongs.
> 
> Having to put all drivers for all PCI/USB/whatever stuff on the
> initramfs will likely be a problem (regarding disk space) for people
> who need to boot the kernel from a floppy disk without having to
> change disks during boot (think of nfsroot without etherboot).

I agree.  It's a lot of drivers (and it's growing.)  It will help out
people booting from a hard disk the most (which happen to be the
majority of people :)

thanks,

greg k-h
