Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUBSRnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUBSRnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:43:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:46513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267440AbUBSRnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:43:04 -0500
Date: Thu, 19 Feb 2004 09:35:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: reference_init.pl for Linux 2.6
Message-Id: <20040219093527.77b7b053.rddunlap@osdl.org>
In-Reply-To: <2263.1077192048@ocs3.ocs.com.au>
References: <20040218182313.7b7b915e.rddunlap@osdl.org>
	<2263.1077192048@ocs3.ocs.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 23:00:48 +1100 Keith Owens <kaos@ocs.com.au> wrote:

| On Wed, 18 Feb 2004 18:23:13 -0800, 
| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >I have updated Keith Owens "reference_init.pl" script for
| >Linux 2.6.  It searches for code that refers to other code
| >sections that they should not reference, such as init code
| >calling exit code or v.v.
| >script for Linux 2.6 is at:
| >http://developer.osdl.org/rddunlap/scripts/reference_init26.pl
| 
| You added '$from !~ /\.data/'.  Any references from the .data section
| to .init or .exit text should be checked.  It is usually a struct
| containing a pointer to code that will be discarded, and is dangerous.
| 
| There is also a spurious comment line,
| #                   $from !~ $line && $line !~ $from &&
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Both fixed and reposted.
The output probably has a bit more false positives reported now.

script:
http://developer.osdl.org/rddunlap/scripts/reference_init26.pl

output on linux-2.6.3 with CONFIG_HOTPLUG=n and very few modules:
http://developer.osdl.org/rddunlap/scripts/badrefs.out


Thanks, Keith.
--
~Randy
