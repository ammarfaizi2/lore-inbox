Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVASVMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVASVMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVASVM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:12:29 -0500
Received: from ozlabs.org ([203.10.76.45]:48351 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261894AbVASVM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:12:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16878.11077.556326.769738@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jan 2005 20:41:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Olaf Hering <olh@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] raid6: altivec support
In-Reply-To: <1106120622.10851.42.camel@baythorne.infradead.org>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	<20050109151353.GA9508@suse.de>
	<1105956993.26551.327.camel@hades.cambridge.redhat.com>
	<1106107876.4534.163.camel@gaston>
	<1106120622.10851.42.camel@baythorne.infradead.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

> Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
> like mips/parisc/s390. Or would that get vetoed on the basis that we
> don't have all that horrid non-OF platform support in ppc64 yet, and
> we're still kidding ourselves that all those embedded vendors will
> either not notice ppc64 or will use OF?

I'm going to insist that every new ppc64 platform supplies a device
tree.  They don't have to have OF but they do need to have the booter
or wrapper supply a flattened device tree (which is just a few kB of
binary data as far as the booter/wrapper is concerned).  It doesn't
have to include all the 

As for merging ppc32 and ppc64, I think it would end up an awful ifdef
mess, but if you can see a clean way to do it, send me a patch. :)

Paul.
