Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUCQVJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUCQVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:09:30 -0500
Received: from mhub-m5.tc.umn.edu ([160.94.23.35]:45287 "EHLO
	mhub-m5.tc.umn.edu") by vger.kernel.org with ESMTP id S262064AbUCQVJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:09:28 -0500
X-Umn-Remote-Mta: [N] qix.software.umn.edu [128.101.65.36] #+LO
Message-Id: <200403172109.i2HL9RcP007960@qix.software.umn.edu>
Date: Wed, 17 Mar 2004 15:09:27 CST
From: Matthew Reppert <repp0017@umn.edu>
Subject: Re: SCSI emulation - CD-R
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
X-Tick-Nemesis: American Maid
X-remote-user-ip: 68.225.171.105
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2004, Karel Kulhavy <Karel Kulhavy
<clock@atrey.karlin.mff.cuni.cz>> wrote:
> Hello
> 
> When I want an ATAPI CD-writer to appear on device (21,0) (/dev/sg0)
> using the scsi emulation mechanisms, which bits have to be on and off
> from the following 4 config bits in make menuconfig?
> * IDE/ATAPI CDROM support
> * SCSI emulation support
> * SCSI CDROM support
> * SCSI generic support
> 
> How can this information be derived from linux kernel documentation? I
> would like to understand the mechanism beyond deriving this information
> from the linux kernel documentation so that next time, when solving some
> other problem, I could use the same approach and not need to write here
> on linux-kernel.

The first time I had to set up a CD writer to work with Linux, I checked
(what is now) the Linux Documentation Project http://www.tldp.org/ which
has a nice CD-writer HOWTO document, detailing not only how you need to
configure your kernel, but also how to use the userspace tools to burn
CDs.

However, with recent kernels and tools, you don't need to (and shouldn't)
use ide-scsi to use ATAPI CD writers. cdrecord dev=/dev/hdc (assuming
that's
the correct IDE device) works just fine.

Matt

