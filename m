Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUCKNkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUCKNkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:40:11 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:16051 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261258AbUCKNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:40:05 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Len Brown <len.brown@intel.com>
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Thu, 11 Mar 2004 13:38:20 +0000
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <1078987834.2556.84.camel@dhcppc4>
In-Reply-To: <1078987834.2556.84.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403111338.20255.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 06:50, Len Brown wrote:
> On Wed, 2004-03-10 at 07:27, Richard Browning wrote:
> > When operating from the
> > command line it is usual to see a Machine Check Exception error
> > immediately prior to system failure.
>
> details?

CPU 2: Machine Check Exception: 000...0004
CPU 3: Machine Check Exception: 000...0004

Is what I get now. Previously I also got "Kernel Context Corrupt" in addition 
to the above.

The MCE error can be made to appear when, for example, I'm running a 
configure/compile cycle. I thought it might be a SATA issue so installed 
Mandrake on an IDE drive but I got the same error.

As an aside, I'm running Gentoo with CFLAGS=-O2 -march=pentium4 -pipe ... I 
was running CFLAGS=-O3 -march=pentium3 -mcpu=pentium4 -mmmx -ssse2 (and so 
on) with no difference whatsoever (probably shouldn't be a surprise bearing 
in mind the kernel is compiled with its own flags).

I've run MEMTEST with no errors reported. It's a very interesting problem, 
since with SMP only everything works okay. But SMP+Hyperthreading and, sooner 
rather than later, the thing will bomb.

R
