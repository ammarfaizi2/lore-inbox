Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFDK5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFDK5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFDK5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 06:57:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59296 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261316AbVFDK5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 06:57:11 -0400
Message-ID: <1117882628.42a1890479c23@imap.linux.ibm.com>
Date: Sat,  4 Jun 2005 06:57:08 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.182.63.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Stern <stern@rowland.harvard.edu>:

> On Fri, 3 Jun 2005, Vivek Goyal wrote:
> 
> > In previous conversations, Alan Stern had raised the issue of console
> also
> > not working if interrupts are disabled on all the devices. I am not sure
> > but this should be working at least for serial consoles and vga text
> consoles.
> > May be sufficient to capture the dump.
> 
> This isn't an issue for x86.  It affects other architectures, in which the 
> system console is managed during the early stages of booting by the 
> platform firmware.  I suppose serial consoles would always work.
> 

Hi Alan, I know very little about consoles and their working.
I had a question. Even if console is being managed by platform firmware, in
initial states of booting, does it require interrupts to be enabled at 
VGA contorller (at least for the simple text mode). I was quickly browsing
through drivers/video/console/vgacon.c and did not look like that this
console driver needed interrupts to be enabled at the controller.

Anyway, looks like serial consoles will always work. So at least this can be
done for kdump case (CONFIG_CRASH_DUMP) and not generic kernel. Or, as I
mentioned in previous mail, while pre-loading capture kernel, pass a command
line parameter containing pci dev id of console and capture kernel does not 
disable interrupts on this console.  

Thanks
Vivek
