Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUALCOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUALCOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:14:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:41665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265875AbUALCOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:14:00 -0500
Date: Sun, 11 Jan 2004 18:13:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1: A couple of problems
Message-Id: <20040111181327.68666d23.akpm@osdl.org>
In-Reply-To: <200401111239.15445.gallir@uib.es>
References: <200401111239.15445.gallir@uib.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> wrote:
>
> Hi Andrew, just a copule of problems with kernel 2.6.1-mm1
> 
> - artsd running with ALSA gives the error: "CPU overloading, stopping" 
> just few seconds after it began to play a song. It's a P4 HT with SMP 
> enabled.

That message came from artsd, not the kernel I assume.  There's a big ALSA
patch in mm1, but how it could cause artsd to do this I do not know.

> - Xfree hang: in a Dell Latitude laptop (P3-M 933), xfree (4.3, last 
> version in Debian experimental) hangs and shows a white screen. The 
> keyboard is also blocked, but login from the network is still OK. There 
> is no any error message. I also see the same effect when I tryed to run 
> Xine in full screen mode.

Could you please do a `patch -p1 -R' of

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/broken-out/DRM-cvs-update.patch

and see if that fixes it?
