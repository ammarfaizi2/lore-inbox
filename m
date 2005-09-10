Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVIJHwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVIJHwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVIJHwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 03:52:39 -0400
Received: from havoc.gtf.org ([69.61.125.42]:39075 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932271AbVIJHwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 03:52:39 -0400
Date: Sat, 10 Sep 2005 03:52:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jim Gifford <maillist@jg555.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Pure 64 bootloaders
Message-ID: <20050910075235.GA28321@havoc.gtf.org>
References: <43228E4E.4050103@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43228E4E.4050103@jg555.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 12:42:06AM -0700, Jim Gifford wrote:
> I have been working on a project to create a Pure 64 bit distro of 
> linux, nothing 32 bit in the system. I can accomplish that with no 
> issues pretty much on all platforms, with the exception of the 
> bootloaders. It just seems odd, that all the bootloaders seem to have 
> gcc -m32 in their makefiles.
> 
> Silo on the Sparc has gcc -m32
> Grub on the x86 platforms has gcc -m32
> 
> The only one that builds and works is Lilo, which most people are moving 
> away from.
> 
> So for my question, why does a bootloader have to be 32bit?
> Anyone got 64 bit bootloaders for Sparc or x86_64 machines?
> Are there technical limitations that bootloaders can't be 64 bit?
> If we can't have a pure64 environment, why does the Kernel support it?

It depends on the mode the CPU is in, at boot time.  Also, there are size
constraints, as 64-bit code is usually larger.

There's nothing stopping you from writing a bootloader that immediately
put the CPU into 64-bit mode, and then proceeds from there...

	Jeff



