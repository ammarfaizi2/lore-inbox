Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUHCVbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUHCVbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUHCVbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:31:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30668 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266877AbUHCVbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:31:06 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Tue, 3 Aug 2004 14:30:56 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040803211948.59456.qmail@web14921.mail.yahoo.com> <200408031428.25853.jbarnes@engr.sgi.com>
In-Reply-To: <200408031428.25853.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031430.56395.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 2:28 pm, Jesse Barnes wrote:
> > Both of the video ROMs are at 00020000, won't they end up on top of
> > each other when enabled?
>
> Yeah, it doesn't look like they've been properly assigned addresses.  But
> then I've also seen lspci lie, you can check /sys/devices/.../config for
> the actual resource values.  If they're sane then things are more likely to
> work.

Oops, I mean /sys/devices/.../resource.  E.g.

jbarnes@mill:~$ cat /sys/devices/pci0002\:06/0002\:06\:0f.0/resource
0x00000000f5200000 0x00000000f53fffff 0x0000000000000200
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x00000000f5100000 0x00000000f51fffff 0x0000000000007200

Jesse
