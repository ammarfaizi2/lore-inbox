Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWBLRk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWBLRk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWBLRjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:39:55 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:34947 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id S1750822AbWBLRjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:39:41 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 12 Feb 2006 18:39:26 +0100
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
Message-ID: <20060212173926.GA6254@iram.es>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 05:13:50PM +0000, Roger Leigh wrote:
> Hi folks,
> 
> When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
> Freescale 7447A):
> 
> $ date && touch f && ls -l f && rm -f f && date
> Sun Feb 12 12:20:14 GMT 2006
> -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
> Sun Feb 12 12:20:14 GMT 2006
> 
> Notice the timestamp is 3 minutes in the future compared with the
> system time.  "make" is not a very happy bunny running on this kernel
> due to every touched file being 3 minutes in the future.
> 
> When the same command is run on 2.6.15.3:
> 
> $ date && touch f && ls -l f && rm -f f && date
> Sun Feb 12 14:27:27 GMT 2006
> -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 14:27
> Sun Feb 12 14:27:27 GMT 2006
> 
> In this case the times are identical, as you would expect.
> 
> In both these cases, the chrony NTP daemon is running, if that might
> be a problem.

I don't know whether it is reloated, but since I installed
a 2.6.16-rc2 kernel on my G4/466, I have log messages
that claim that the clock error rate is too large for NTP
to correct (larger than 512ppm).

	Gabriel
