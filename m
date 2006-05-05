Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWEETVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWEETVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWEETVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 15:21:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59271 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751214AbWEETVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 15:21:37 -0400
Message-ID: <445BA584.40309@us.ibm.com>
Date: Fri, 05 May 2006 12:20:36 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow	userspace
 (Xorg) to enable devices without doing foul direct access
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>	 <200605041309.53910.bjorn.helgaas@hp.com>	 <445A51F1.9040500@linux.intel.com>	 <200605041326.36518.bjorn.helgaas@hp.com>	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>	 <1146776736.27727.11.camel@localhost.localdomain>	 <mj+md-20060504.211425.25445.atrey@ucw.cz>	 <1146778197.27727.26.camel@localhost.localdomain>	 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> <1146784923.4581.3.camel@localhost.localdomain>
In-Reply-To: <1146784923.4581.3.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Peter Jones wrote:
> On Thu, 2006-05-04 at 17:38 -0400, Jon Smirl wrote:
> 
>># cd /sys/bus/pci/devices/0000:01:00.0
>># echo 1 >rom
>># hexdump -C rom
>>
>>As far as I know this works on every platform, not just the PC one.
> 
> Yep, you're right, this works.  So we don't necessarily need it for the
> vbetool case.  X still could use it though, instead of their scary
> poke-at-memory way.

Dave Airlie recently changed X to use sysfs for reading ROMs.  I'm also
working on some changes to eliminate nearly all of the PCI bus poking
that X does.  Search for "PCI rework" or "libpciaccess" in the xorg list
archives.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEW6WDX1gOwKyEAw8RAt/aAJ0VDgqBNLbvyKExD0oS3nM5UsAFugCfaJpf
MLSBYFA6e96gyiAr4/j4T14=
=pJQD
-----END PGP SIGNATURE-----
