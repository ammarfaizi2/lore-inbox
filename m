Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUCEQnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUCEQmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:42:42 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56837 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262646AbUCEQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:42:35 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: initrd does not boot in 2.6.3, working in 2.4.25
Date: Fri, 5 Mar 2004 18:31:31 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <200403051238.53470.vda@port.imtp.ilyichevsk.odessa.ua> <20040305110451.GR655@holomorphy.com>
In-Reply-To: <20040305110451.GR655@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403051831.31271.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 13:04, William Lee Irwin III wrote:
> On Fri, Mar 05, 2004 at 12:38:53PM +0200, vda wrote:
> > I am using initrd in order to configure ethernet and
> > mount NFS root. It works with 2.4.25 kernel, like this:
> > linld image=2425 initrd=image.gz vga=4 "cl=root=/dev/ram
> > init=/linuxrc.nfs.vda devfs=mount" that is, it unpacks image.gz into
> > ramdisk #0, mounts it,
> > mounts devfs on /dev and execs /linuxrc.nfs.vda.
> > When I tried to boot 2.6.3 with
> > linld image=263 initrd=image.gz vga=4 "cl=root=/dev/ram
> > init=/linuxrc.nfs.vda devfs=mount" it unpacks image.gz into ramdisk #0,
> > mounts it,
> > mounts devfs on /dev and ... complains about NFS server.
> > Wow. I did not say /dev/nfs, what NFS?
> > ...
> > VFS: Mounted root (ext2 filesystem)
> > Mounted devfs on /dev
> > 	(here 2.4.25 would say "Freed unused kernel mem..." and exec init)
> > Root-NFS: No NFS server available, giving up
> > VFS: Unable to mount root fs via NFS, trying floppy
> > VFS: Insert root floppy and press ENTER
> > Omitting devfs=mount does not help.
> > root=/dev/ram0, root=/dev/rd/0 does not help.
> > Config attached.
>
> nfsroot works in 2.6.3 and above here. I'm not sure you need it per se
> for initrd's; I think the way it's intended to work with that is for
> the scripts to configure network interfaces, mount the nfsroot, and then
> pivot_root(). Can you try without initrd?
>
> Also, try passing ip= for these things.

I run these things everyday.
nfsroot and ip=.... works, no question about that.

Just imagine all-modular kernel which needs to load ethernet driver first,
*then* mount nfs root and pivot_root. Or nfsroot-over-wireless :)
--
vda

