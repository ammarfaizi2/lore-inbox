Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWC1Xtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWC1Xtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWC1Xtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:49:52 -0500
Received: from main.gmane.org ([80.91.229.2]:25049 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964847AbWC1Xtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:49:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Who wants to test cracklinux??
Date: Wed, 29 Mar 2006 00:49:43 +0100
Message-ID: <yw1x8xquruy0.fsf@agrajag.inprovide.com>
References: <20060328221223.80753cab.letterdrop@gmx.de> <20060328224929.GC5760@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:KTEiJfVGXq77j4wQrEkmvwJAYNc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> I've written a small kernel module & shared object for kernel 2.6 to
>> enable the following for normal users:
>> 
>> - inb()/outb()... via a wrapper function
>
> ioperm() does that already, no? You mean, you enable it for non-root,
> too? That's security hole.
>
>> - enable direct IO access (like ioperm())
>> - direct access on physical memory addresses
>
> read/write on /dev/mem. chmod 666 /dev/mem if you want to allow normal
> users to access physical memory (security hole, again).

It's a security risk, but one that you might sometimes take to gain
some performance on a non-critical machine.  I've done this in the
past to be able to play videos smoothly on a slow machine.

>> - installation of user space ISR
>
> That seems nice. Does it work with PCI shared interrupts?

I obviously can't comment on this case, but I've successfully done it
previously, so it's demonstrably possible.  The code is all available
from vidix.sf.net, although it's not updated to the latest ways of
doing things.

-- 
Måns Rullgård
mru@inprovide.com

