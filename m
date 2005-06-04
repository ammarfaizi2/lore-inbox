Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFDPgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFDPgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFDPgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:36:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:2279 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261315AbVFDPgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:36:00 -0400
Date: Sat, 4 Jun 2005 11:35:59 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bodo Eggert <7eggert@gmx.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
In-Reply-To: <1117882628.42a1890479c23@imap.linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0506041126030.5133-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2005, Vivek Goyal wrote:

> Hi Alan, I know very little about consoles and their working.
> I had a question. Even if console is being managed by platform firmware, in
> initial states of booting, does it require interrupts to be enabled at 
> VGA contorller (at least for the simple text mode). I was quickly browsing
> through drivers/video/console/vgacon.c and did not look like that this
> console driver needed interrupts to be enabled at the controller.

This isn't an issue for VGA, as far as I know.  It applies to
architectures like PPC-64 and perhaps Alpha or PA-Risc.  And I don't know
the details; ask Grant Grundler.

> Anyway, looks like serial consoles will always work. So at least this can be
> done for kdump case (CONFIG_CRASH_DUMP) and not generic kernel. Or, as I
> mentioned in previous mail, while pre-loading capture kernel, pass a command
> line parameter containing pci dev id of console and capture kernel does not 
> disable interrupts on this console.  

I suspect you're right that implementing this only in kdump kernels will 
work okay.

For people interesting in reading some old threads on the subject, here 
are some pointers:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111055702309788&w=2

http://marc.theaimsgroup.com/?l=linux-kernel&m=98383052711171&w=2

Alan Stern

