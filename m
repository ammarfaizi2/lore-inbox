Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbTCMVDJ>; Thu, 13 Mar 2003 16:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbTCMVDI>; Thu, 13 Mar 2003 16:03:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:10459 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262546AbTCMVDH>;
	Thu, 13 Mar 2003 16:03:07 -0500
Date: Thu, 13 Mar 2003 13:08:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: thunder7@xs4all.nl
Cc: linux-fbdev-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 tdfxfb problems: 'fb: can't remap 3Dfx VooDoo 5 register
 area'
Message-Id: <20030313130824.5ab1673e.akpm@digeo.com>
In-Reply-To: <20030313155829.GA1338@middle.of.nowhere>
References: <20030313155829.GA1338@middle.of.nowhere>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 21:13:35.0782 (UTC) FILETIME=[68DA7C60:01C2E9A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> When I try to use the tdfxfb framebuffer module with the 2.5.64 kernel,
> I get the following message:
> 
> fb: Can't remap 3Dfx Voodoo5 register area.
> 
> Is there any way to solve this? I tried google, but I can't find any
> solution for this :-(
> 
> If I compile the tdfxfb framebuffer into the kernel, I get an oops
> during booting with the backlog below. That is rather less nice, but
> even as a module it won't work.
> 
> Thanks for your attention,
> Jurriaan
> 
> remap_area_pages
> get_vm_Area
> __ioremap
> rioremap_nocache
> sysfs_mkdir
> pci_device_probe
> bus_match
> driver_attach
> bus_add_driver
> driver_register
> proc_register
> pci_register_driver
> init
> init

This looks like the sysfs oops in 2.5.64 plus assorted stack gunk.  Suggest
you retest with 2.5.64 plus

http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-1.1068.1.17-to-1.1104.txt.gz


