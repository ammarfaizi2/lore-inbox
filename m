Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRHaWlL>; Fri, 31 Aug 2001 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHaWlB>; Fri, 31 Aug 2001 18:41:01 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:39420 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269645AbRHaWko>; Fri, 31 Aug 2001 18:40:44 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 31 Aug 2001 16:40:28 -0600
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Russell Coker'" <russell@coker.com.au>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
Message-ID: <20010831164028.I541@turbolinux.com>
Mail-Followup-To: "Grover, Andrew" <andrew.grover@intel.com>,
	'Russell Coker' <russell@coker.com.au>,
	"Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0DB@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0DB@orsmsx35.jf.intel.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31, 2001  14:49 -0700, Grover, Andrew wrote:
> Just for discussion's sake, I would like to point out that other OSs do have
> loaders that can load boot drivers, and they can use this to increase the
> modularity of their kernel. FreeBSD's and Win2k's bootloaders are examples.
> Win2K even abstracts all SMP/UP code into a module (the HAL) and loads this
> at boot, thus using the same kernel for both.

Just FYI, this is just around the corner.  Al Viro has made it mandatory
(I believe) to have a very simple initramfs, for doing things like mounting
the root filesystem and setting up other services which are now done in
the kernel at boot time.  This initramfs (very similar to initrd) is at
the end of the kernel image, so it can't get lost and doesn't require
sending a separate file (i.e. for network booting, etc).

> possibly abstracting SMP/UP from the kernel proper?

Will never happen, as there would probably be overhead for both UP and SMP
to do this.  If you want something like this (for ease of admin or so),
you can generally run the SMP kernel on UP systems and take the performance
hit, but not everyone will do that.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

