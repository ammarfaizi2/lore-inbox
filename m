Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVFCSdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFCSdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVFCSdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:33:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26792 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261499AbVFCSde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:33:34 -0400
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
References: <Pine.LNX.4.44L0.0506031111080.6451-100000@iolanthe.rowland.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Jun 2005 12:26:33 -0600
In-Reply-To: <Pine.LNX.4.44L0.0506031111080.6451-100000@iolanthe.rowland.org>
Message-ID: <m1ekbj9u06.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 3 Jun 2005, Vivek Goyal wrote:
> 
> > In previous conversations, Alan Stern had raised the issue of console also
> > not working if interrupts are disabled on all the devices. I am not sure
> > but this should be working at least for serial consoles and vga text consoles.
> 
> > May be sufficient to capture the dump.
> 
> This isn't an issue for x86.  It affects other architectures, in which the 
> system console is managed during the early stages of booting by the 
> platform firmware.  I suppose serial consoles would always work.

In the plain kexec case that should be doable.  I don't think
I have heard of a kdump case where we can work with the platform
firmware.


Eric

