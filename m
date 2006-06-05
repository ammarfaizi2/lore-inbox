Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751340AbWFETs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWFETs4 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWFETs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:48:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751340AbWFETsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:48:55 -0400
Date: Mon, 5 Jun 2006 15:48:45 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605194844.GA6143@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060603232004.68c4e1e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 11:20:04PM -0700, Andrew Morton wrote:
 > 
 > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
 > 
 > - Lots of PCI and USB updates
 > 
 > - The various lock validator, stack backtracing and IRQ management problems
 >   are converging, but we're not quite there yet.

Thought I'd try my bi-annual "poke at -mm". Results were less
than spectacular.

http://www.codemonkey.org.uk/junk/DSC00347.JPG
First the sound driver oopsed.

Then, the whole thing locked up after probing the parallel port.
I disabled it in the BIOS, and then it locked up probing the floppy drive..
http://www.codemonkey.org.uk/junk/DSC00348.JPG

System is still alive, and responds to keyboard, but makes no forward progress.

(sysrq-B spewed a lockdep trace and then rebooted. I'll try and get
that hooked up to a serial console)

On a whim, I enabled the floppy drive in the BIOS, and rebooted.
That got me here. http://www.codemonkey.org.uk/junk/DSC00349.JPG
Same dead userspace.

Off to find a serial cable.

		Dave

-- 
http://www.codemonkey.org.uk
