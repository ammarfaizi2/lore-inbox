Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUEDRwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUEDRwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbUEDRwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 13:52:17 -0400
Received: from eatkyo297232.adsl.ppp.infoweb.ne.jp ([219.97.64.232]:61102 "HELO
	pia3.com") by vger.kernel.org with SMTP id S264541AbUEDRwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 13:52:11 -0400
Date: Wed, 5 May 2004 02:52:22 +0900
From: Keiichiro Tokunaga <kei@pia3.com>
To: Greg KH <greg@kroah.com>
Cc: Keiichiro Tokunaga <tokunaga.keiich@soft.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] New sysfs tree for hotplug
Message-Id: <20040505025222.70df6716.kei@pia3.com>
Organization: pia3.com
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 16:55:55 -0700, Greg KH wrote:
> On Mon, Apr 26, 2004 at 02:58:08PM +0900, Keiichiro Tokunaga wrote:
> >
> > I think it depends on a hotplug driver that is invoked when writing to
> > a "eject" file. In the board case, a board hotplug driver (I'm making)
> > handles those CPUs, memory, and PCI slots on the board. So my
> > story for board hotplug is:
> >
> > - user checks/knows what resources are on the board (dependency)
> > - user writes to the "eject" file of the board properly (invocation)
> 
> Why not make a program that does all of this from userspace? It would
> turn off the proper CPUs, memory, and pci slots for a specific "board".
> Otherwise you are going to have to either:
> - hook the current CPU, memory, and pci hotplug code to allow it
> to be called from within the kernel
> - have your kernel code write to a the sysfs files from within
> kernelspace.
> 
> Neither of which are acceptable things :(

Actually I'm expecting to use the first option (hook) in the
current code of the board hotplug :)
The board hotplug is supposed to support "board attachment and
detachment".  That requires hardware manipulation.  So, the
hotplug code (at least, a part of the code) needs to live in
the kernel space.  Anyway, I would finish the first rough patches
in a few days and post them.  Please take a look at them to see
what I'm trying to do.

Thank you,
Kei
