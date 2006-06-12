Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWFLROx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWFLROx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWFLROx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:14:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:27871 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751268AbWFLROw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:14:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 built-in command line
Date: Mon, 12 Jun 2006 10:14:24 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6k7dg$gtg$1@terminus.zytor.com>
References: <20060611215530.GH24227@waste.org> <Pine.LNX.4.61.0606120129230.8102@yvahk01.tjqt.qr> <20060611234746.GJ24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150132464 17329 127.0.0.1 (12 Jun 2006 17:14:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jun 2006 17:14:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060611234746.GJ24227@waste.org>
By author:    Matt Mackall <mpm@selenic.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Jun 12, 2006 at 01:30:27AM +0200, Jan Engelhardt wrote:
> > >
> > >This patch allows building in a kernel command line on x86 as is
> > >possible on several other arches.
> > >
> > >+config CMDLINE
> > >+	  On some systems, there is no way for the boot loader to pass
> > >+	  arguments to the kernel. For these platforms, you can supply
> > >+	  some command-line options at build time by entering them
> > >+	  here. In most cases you will need to specify the root device
> > >+	  here.
> > 
> > Thank God x86 does not have that limitation. Or am I missing some exotic 
> > bootloader that fails to pass in arguments?
> 
> Yes. Note that this depends on CONFIG_EMBEDDED. It's quite common for
> embedded apps to roll their own trivial ROM-based boot loaders. It's
> also quite common for embedded boxen to run up against the command
> line length limit that's hardcoded in the boot protocol.
> 

There is no command line length limit hard-coded in the boot protocol
per se (at least not for version 2.02 or higher.)  The length limit is
hard-coded in the *kernel*, not in the protocol.

	-hpa

