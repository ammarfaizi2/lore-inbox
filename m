Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbTGIR6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbTGIR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:58:24 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:11457 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S268486AbTGIR5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:57:21 -0400
Subject: Re: Compile failure 2.4.22-pre3-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Midian <midian@ihme.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1057772247.3757.9.camel@midux>
References: <20030709124915.3d98054b.ak@suse.de>
	 <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	 <20030709134109.65efa245.ak@suse.de>
	 <1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
	 <20030709185823.1f243367.ak@suse.de>
	 <1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
	 <1057772247.3757.9.camel@midux>
Content-Type: text/plain
Organization: 
Message-Id: <1057774256.8754.46.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 09 Jul 2003 12:10:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 11:37, Midian wrote:
> Hello Alan,
> I've tryed to compile 2.4.22-pre3-ac1, but every time I get this error:
> 
> arch/i386/kernel/kernel.o(.text.init+0x7803): In function
> `setup_ioapic_ids_from_mpc':
> : undefined reference to `xapic_support'
> arch/i386/kernel/kernel.o(.text.init+0x7a16): In function
> `setup_ioapic_ids_from_mpc':
> : undefined reference to `xapic_support'
> make: *** [vmlinux] Error 1
> 
> I've tryed to search for patches from the mailing list with no luck, is
> there some patches for this?
> 
> Regards

I posted this workaround here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105760102522650&w=2

but as Adrian Bunk pointed out in a response, the problem is that
"changes to arch/i386/kernel/mpparse.c got lost at the update of -ac to -pre3".

If you want to be slightly more adventurous than using my
workaround patch, you could copy the mpparse.c file from 2.4.21-ac4.
That was compile tested but not run tested.

Steven

