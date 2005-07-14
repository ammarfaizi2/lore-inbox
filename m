Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVGNFxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVGNFxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 01:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVGNFxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 01:53:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8583 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262312AbVGNFxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 01:53:13 -0400
Date: Thu, 14 Jul 2005 11:23:02 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: Current kexec status?
Message-ID: <20050714055301.GA4133@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050713104848.GJ4561@charite.de> <20050713122257.GA29477@in.ibm.com> <20050713123239.GT4561@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713123239.GT4561@charite.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 02:32:39PM +0200, Ralf Hildebrandt wrote:
> * Vivek Goyal <vgoyal@in.ibm.com>:
> 
> > Can you give more details like
> > - Which distro release you are running.
> 
> Debian unstable; since it has no kexec-tools, I built those from source.
> 
> > - Exactly what changes did you do to /etc/init.d/reboot and what steps
> > did you follow to load the kernel (command line options).
> 
> /etc/init.d/reboot:
> ===================
> 
> echo -n "Rebooting... "
> #reboot -d -f -i
> /usr/local/sbin/kexec -f --exec --debug
> 
> Loading the Kernel in /etc/init.d/umountfs, before umount'ing /boot:
> ====================================================================
> 
> echo -n "Loading kernel for kexec()..."
> /usr/local/sbin/kexec --load /vmlinuz
> echo "done."
> 

Please copy all the mails related to kexec and kdump problems to
fastboot mailing list also (fastboot@lists.osdl.org).

Instead of modifying reboot scripts, first can you try following simple 
steps from shell.

1. Load the kernel.
#kexec -l <kernel-image> --append=<boot time options>

2. Drop to run level 3 
# init 3

3. Exec into second kernel
# kexec -e


Thanks
Vivek
