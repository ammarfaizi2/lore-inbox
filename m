Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVECSBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVECSBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVECSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:01:40 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:53733 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261382AbVECSBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:01:38 -0400
Date: Tue, 3 May 2005 14:01:02 -0400
To: Rick Warner <rick@microway.com>, linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503180102.GC2297@csclub.uwaterloo.ca>
References: <20050503012951.GA10459@animx.eu.org> <200505031206.09245.rick@microway.com> <20050503164012.GE11937@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503164012.GE11937@animx.eu.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 12:40:12PM -0400, Wakko Warner wrote:
> This is a little project I'm doing to beable to load a system onto a hard
> drive.  The linux system is short lived by design and will run out of a
> tmpfs root populated by various tgz files found either on CDs or a USB
> stick.
> 
> My goal (which I realize may not be achivable nor is it important in the
> long run) is to get the kernel and the initrd onto a single floppy disk
> (Currently, I'm ~80kb too large for this).
> 
> I decided (remembering 2.2 days and prior when zImage was normally used) to
> try zImage to see what happened.  I was going to compare the size of the
> resulting images.  That's when I hit the problem.
> 
> I understand that upx can compress the kernel better and I also remember
> hearing about utilizing bzip2 as the compressor for the kernel and initrd
> images.
> 
> As far as my question, it still stands.  Is bzImage required (i386/x86) for
> a 2.6 kernel?

Due to the 640k base memory limitations, you need to use bzImage for
any kernel that is over about 500k compressed.  There is absolutely no
reason I can think of for not using bzImage.  All the boot loaders
support it just fine, and the result is the same after loading.  It
doesn't change the size of the kernel, just how large a kernel the boot
loader can load.

With the size of 2.6 kernels I consider zImage imposible to use anymore,
and it has never caused me any trouble to use bzImage.  It seems that
practically bzImage is requried on x86 for 2.6 kernels.  I don't know
how small you could make it if you left out everything except initrd and
cramfs support (assuming your kernel supports cramfs initrd's).  Even
ext2 is rather big.

Len Sorensen
