Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbUL3W4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUL3W4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUL3W4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:56:14 -0500
Received: from linux.us.dell.com ([143.166.224.162]:47021 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261583AbUL3W4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:56:11 -0500
Date: Thu, 30 Dec 2004 16:56:02 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andi Kleen <ak@muc.de>
Cc: YhLu <YhLu@tyan.com>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 256 apic id for amd64
Message-ID: <20041230225602.GA27670@lists.us.dell.com>
References: <3174569B9743D511922F00A0C943142307290EEE@TYANWEB> <m1d5wrlj5p.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5wrlj5p.fsf@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 07:45:22PM +0100, Andi Kleen wrote:
> i386 also has a different (but Intel specific fix) - uses either
> 0xf or 0xff based on the APIC version. Just dropping it seems
> better to me though. I suppose Matt (cc'ed) who apparently
> wrote this code originally used it to work around some BIOS
> bug, and at least we can hope for now that there are no 
> EM64T boxes with that particular BIOS bug.

The MPC spec (I don't have a copy handy anymore) said it's the OS's
job to program the APIC ID into the processor based on what BIOS put
in the MP Table for it.  At the time I wrote the patch, the kernel
didn't do this, so now it does, else all CPUs could wind up with the
same APIC ID, which messed up interrupt routing IIRC.

What's differrent about this x86_64 system in this regard please?

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
