Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbUCELFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUCELFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:05:07 -0500
Received: from holomorphy.com ([207.189.100.168]:50955 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262464AbUCELFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:05:01 -0500
Date: Fri, 5 Mar 2004 03:04:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: initrd does not boot in 2.6.3, working in 2.4.25
Message-ID: <20040305110451.GR655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <200403051238.53470.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403051238.53470.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 12:38:53PM +0200, vda wrote:
> I am using initrd in order to configure ethernet and
> mount NFS root. It works with 2.4.25 kernel, like this:
> linld image=2425 initrd=image.gz vga=4 "cl=root=/dev/ram init=/linuxrc.nfs.vda devfs=mount"
> that is, it unpacks image.gz into ramdisk #0, mounts it,
> mounts devfs on /dev and execs /linuxrc.nfs.vda.
> When I tried to boot 2.6.3 with
> linld image=263 initrd=image.gz vga=4 "cl=root=/dev/ram init=/linuxrc.nfs.vda devfs=mount"
> it unpacks image.gz into ramdisk #0, mounts it,
> mounts devfs on /dev and ... complains about NFS server.
> Wow. I did not say /dev/nfs, what NFS?
> ...
> VFS: Mounted root (ext2 filesystem)
> Mounted devfs on /dev
> 	(here 2.4.25 would say "Freed unused kernel mem..." and exec init)
> Root-NFS: No NFS server available, giving up
> VFS: Unable to mount root fs via NFS, trying floppy
> VFS: Insert root floppy and press ENTER
> Omitting devfs=mount does not help.
> root=/dev/ram0, root=/dev/rd/0 does not help.
> Config attached.

nfsroot works in 2.6.3 and above here. I'm not sure you need it per se
for initrd's; I think the way it's intended to work with that is for
the scripts to configure network interfaces, mount the nfsroot, and then
pivot_root(). Can you try without initrd?
Also, try passing ip= for these things.


-- wli

